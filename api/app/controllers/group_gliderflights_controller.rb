class GroupGliderflightsController < ApplicationController
  include GroupsHelper
  include ApplicationHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_group_member,   only: :destroy
  before_action :set_sideber_data, only: [:new, :show, :edit, :index, :destroy]
  before_action :set_gliderflight_selectors, only: [:new, :create, :edit]

  def new
    current_group = Group.find_by(params[:id])
    @group_gliderflight = current_group.group_gliderflights.build
    @group_members = current_group.users
    @fleet = Fleet.where("group_id = ?", current_group.id)
  end

  def create
    current_group = Group.find_by(params[:id])
    @group_gliderflight = current_group.group_gliderflights.build(group_gliderflight_params)
    if @group_gliderflight.save
      flash[:success] = "グループフライトを登録しました。"
      redirect_to group_gliderflights_path(id: current_group.id)
    else
      render :new
      flash[:danger] = "グループフライトの登録に失敗しました。"
    end
  end

  def index
    @current_group = Group.find_by(params[:id])
    @group_gliderflights = @current_group.group_gliderflights.order(takeoff_time: :asc).page(params[:page]).per(10)
  end

  def show
    @group_gliderflight = GroupGliderflight.find_by(id: params[:id])
  end

  def edit
    @group_gliderflight = GroupGliderflight.find_by(id: params[:id])
    current_group = Group.find_by(params[:id])
    @group_members = current_group.users
    @glider_type = AircraftType.where("category = ?", 'glider')
    @fleet = Fleet.where("group_id = ?", current_group.id)
  end

  def update
    @group_gliderflight = GroupGliderflight.find_by(id: params[:id])
    if @group_gliderflight.update(group_gliderflight_params)
      flash[:success] = "グループフライトを更新しました。"
      group = @group_gliderflight.group
      redirect_to group_gliderflights_path(id: group.id)
    else
      flash[:danger] = "グループフライトの更新に失敗しました。"
      render 'group_gliderflights/edit'
    end
  end

  def destroy
    @group_gliderflight.destroy
    gliderflights = GroupGliderflight.where("user_id = ?", current_user.id).order(log_number: :asc)
    # new_log_number(gliderflights)
    flash[:success] = "選択したグループフライトを削除しました。"
    redirect_to group_gliderflights_url
  end

  private

  def group_gliderflight_params
    params[:group_gliderflight][:takeoff_time] = fix_inputed_time(:group_gliderflight, :takeoff_time)
    params[:group_gliderflight][:release_time] = fix_inputed_time(:group_gliderflight, :release_time)
    params[:group_gliderflight][:landing_time] = fix_inputed_time(:group_gliderflight, :landing_time)
    params.require(:group_gliderflight).permit(:day_flight_number,
                                                :date,
                                                :departure_point,
                                                :arrival_point,
                                                :is_winch,
                                                :fleet,
                                                :front_seat,
                                                :front_flight_role,
                                                :rear_seat,
                                                :rear_flight_role,
                                                :takeoff_time,
                                                :release_time,
                                                :landing_time,
                                                :release_alt,
                                                :creator,
                                                :updater,
                                                :note)
  end

  def correct_group_member
    group_gliderflight = GroupGliderflight.find_by(id: params[:id])
    group = group_gliderflight.group
    @group_gliderflight = group_gliderflight if group.users.include?(current_user)
    redirect_to root_url if @group_gliderflight.nil?
  end
end
