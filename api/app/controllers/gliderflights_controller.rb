class GliderflightsController < ApplicationController
  include SessionsHelper
  include GliderflightsHelper
  include ApplicationHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:new, :edit, :show, :index, :destroy, :new_from_groups]
  before_action :set_gliderflight_selectors, only: [:new, :edit, :new_from_groups]

  def new
    @gliderflight = Gliderflight.new
  end

  def create
    @gliderflight = current_user.gliderflights.build(gliderflight_params)
    if @gliderflight.save
      new_log_number
      flash[:success] = "フライトログを投稿しました。"
      redirect_to gliderflights_url
    else
      render 'gliderflights/new'
    end
  end

  def show
    @gliderflight = Gliderflight.find_by(id: params[:id])
    @micropost = Micropost.new
  end

  def edit
    @gliderflight = Gliderflight.find_by(id: params[:id])
  end

  def update
    @gliderflight = Gliderflight.find_by(id: params[:id])
    if @gliderflight.update(gliderflight_params)
      new_log_number
      flash[:success] = "フライトログを更新しました。"
      redirect_to gliderflights_url
    else
      render 'gliderflights/edit'
    end
  end

  def index
    # @gliderflights = Gliderflight.where("user_id = ?", current_user.id).includes(:aircraft_type).order(log_number: :asc)
    @gliderflights = current_user.gliderflights.order(log_number: :asc)
    @logbook_flights = @gliderflights.page(params[:page]).per(10)
    @glider_initial_log = @current_user.glider_initial_log
  end

  def destroy
    @gliderflight.destroy
    new_log_number
    flash[:success] = "フライトログを削除しました。"
    redirect_to gliderflights_url
  end

  def new_from_groups
    flights_from_groups = GliderGroupFlight.where("front_seat = ? OR rear_seat = ?", current_user.id, current_user.id).order(takeoff_time: :asc)
    @gliderflights = Form::GliderflightCollection.new(flights_from_groups, current_user, 'new')
    @logged_flights = Gliderflight.where("user_id = ?", current_user.id).order(log_number: :asc)
    @glider_type = AircraftType.where("category = ?", 'glider')
    render 'gliderflights/from_groups/new_from_groups'
  end

  def create_from_groups
    @gliderflights = Form::GliderflightCollection.new(new_from_groups_params, current_user, 'create')
    if @gliderflights.save_collection
      new_log_number
      flash[:success] = "グループフライトからフライトログを取得しました。"
      @glider_type = AircraftType.where("category = ?", 'glider')
      redirect_to gliderflights_url
    else
      @glider_type = AircraftType.where("category = ?", 'glider')
      @logged_flights = Gliderflight.where("user_id = ?", current_user.id).order(log_number: :asc)
      # flash[:danger] = "フライトログブックへの登録中にエラーが発生しました。"
      render 'gliderflights/from_groups/new_from_groups'
    end
  end

  private

  def practice
    params.require(:gliderflight).permit(:name, :date)
  end

  def gliderflight_params
    params.require(:gliderflight).permit(:log_number,
                                          :date,
                                          :aircraft_type_id,
                                          :glider_ident,
                                          :departure_point,
                                          :arrival_point,
                                          :number_of_landing,
                                          :takeoff_time,
                                          :landing_time,
                                          :release_alt,
                                          :flight_role,
                                          :is_motor_glider,
                                          :is_power_flight,
                                          :is_winch,
                                          :is_cross_country,
                                          :is_instructor,
                                          :is_stall_recovery,
                                          :note)
  end

  def new_from_groups_params
    params.require(:gliderflights)
  end

  def correct_user
    @gliderflight = current_user.gliderflights.find_by(id: params[:id])
    redirect_to root_url if @gliderflight.nil?
  end
end
