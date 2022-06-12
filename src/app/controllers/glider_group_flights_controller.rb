class GliderGroupFlightsController < ApplicationController
  include GroupsHelper
  include ApplicationHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_group_member,   only: :destroy
  before_action :set_sideber_data, only: [:new, :show, :edit, :index, :destroy]
  before_action :set_glider_flight_selectors, only: [:new, :create, :edit]

  def new
    current_group = Group.find_by(params[:id])
    @glider_group_flight = current_group.glider_group_flights.build
    @group_members = current_group.users
    @fleet = Fleet.where("group_id = ?", current_group.id)
  end

  def create
    current_group = Group.find_by(params[:id])
    @glider_group_flight = current_group.glider_group_flights.build(glider_group_flight_params)
    if @glider_group_flight.save
      flash[:success] = "グループフライトを登録しました。"
      redirect_to glider_group_flights_path(id: current_group.id)
    else
      render :new
      flash[:danger] = "グループフライトの登録に失敗しました。"
    end
  end

  def index
    @current_group = Group.find_by(params[:id])
    @glider_group_flights = @current_group.glider_group_flights.order(takeoff_time: :asc).page(params[:page]).per(10)
  end

  def show
    @glider_group_flight = GliderGroupFlight.find_by(id: params[:id])
  end

  def edit
    @glider_group_flight = GliderGroupFlight.find_by(id: params[:id])
    current_group = Group.find_by(params[:id])
    @group_members = current_group.users
    @glider_type = AircraftType.where("category = ?", 'glider')
    @fleet = Fleet.where("group_id = ?", current_group.id)
  end

  def update
    @glider_group_flight = GliderGroupFlight.find_by(id: params[:id])
    if @glider_group_flight.update(glider_group_flight_params)
      flash[:success] = "グループフライトを更新しました。"
      group = @glider_group_flight.group
      redirect_to glider_group_flights_path(id: group.id)
    else
      flash[:danger] = "グループフライトの更新に失敗しました。"
      render 'glider_group_flights/edit'
    end
  end

  def destroy
    @glider_group_flight.destroy
    glider_flights = GliderGroupFlight.where("user_id = ?", current_user.id).order(log_number: :asc)
    # new_log_number(glider_flights)
    flash[:success] = "選択したグループフライトを削除しました。"
    redirect_to glider_group_flights_url
    # redirect_to request.referrer || root_url
  end

  private

  def glider_group_flight_params
    params[:glider_group_flight][:takeoff_time] = fix_inputed_time(:glider_group_flight, :takeoff_time)
    params[:glider_group_flight][:release_time] = fix_inputed_time(:glider_group_flight, :release_time)
    params[:glider_group_flight][:landing_time] = fix_inputed_time(:glider_group_flight, :landing_time)
    params.require(:glider_group_flight).permit(:day_flight_number,
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
    glider_group_flight = GliderGroupFlight.find_by(id: params[:id])
    group = glider_group_flight.group
    @glider_group_flight = glider_group_flight if group.users.include?(current_user)
    redirect_to root_url if @glider_group_flight.nil?
  end
end
