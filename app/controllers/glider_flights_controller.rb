class GliderFlightsController < ApplicationController
  include SessionsHelper
  include GliderFlightsHelper
  include ApplicationHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :set_sideber_data, only: [:new, :edit, :show, :index]

  def new
    @glider_flight = GliderFlight.new
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  def create
    @glider_flight = current_user.glider_flights.build(glider_flight_params)
    if @glider_flight.save
      new_log_number
      flash[:success] = "フライトログの登録に成功しました！"
      redirect_to glider_flights_url
    else
      @glider_type = AircraftType.where("category = ?", 'glider')
      render 'glider_flights/new'
    end
  end

  def show
    @glider_flight = GliderFlight.find_by(id: params[:id])
    @micropost = Micropost.new
  end

  def edit
    @glider_flight = GliderFlight.find_by(id: params[:id])
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  def update
    @glider_flight = GliderFlight.find_by(id: params[:id])
    if @glider_flight.update(glider_flight_params)
      new_log_number
      flash[:success] = "フライトログの更新に成功しました！"
      redirect_to glider_flights_url
    else
      @glider_type = AircraftType.where("category = ?", 'glider')
      render 'glider_flights/edit'
    end
  end

  def index
    @glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(log_number: :asc).page(params[:page]).per(10)
    @glider_initial_log = @current_user.glider_initial_log
  end

  def destroy
    @glider_flight.destroy
    new_log_number
    flash[:success] = "選択したフライトログを削除しました。"
    redirect_to request.referrer || root_url
  end

  def new_from_groups
    flights_from_groups = GliderGroupFlight.where("front_seat = ? OR rear_seat = ?", current_user.id, current_user.id).order(takeoff_time: :asc)
    @glider_flights = Form::GliderFlightCollection.new(flights_from_groups, current_user, 'new')
    @logged_flights = GliderFlight.where("user_id = ?", current_user.id).order(log_number: :asc)
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  def create_from_groups
    @glider_flights = Form::GliderFlightCollection.new(new_from_groups_params, current_user, 'create')
    if @glider_flights.save_collection
      new_log_number
      flash[:success] = "グループフライトからのログ取得に成功しました！"
      @glider_type = AircraftType.where("category = ?", 'glider')
      redirect_to glider_flights_url
    else
      @glider_type = AircraftType.where("category = ?", 'glider')
      render :new_from_groups
    end
  end

  private

  def glider_flight_params
    params.require(:glider_flight).permit(:log_number, :date, :glider_type, :glider_ident, :departure_and_arrival_point, :number_of_landing, :takeoff_time, :landing_time, :release_alt, :flight_role, :is_motor_glider, :is_power_flight, :is_winch, :is_cross_country, :is_instructor, :is_stall_recovery, :close_log, :note)
  end

  def new_from_groups_params
    params.require(:glider_flights)
  end

  def correct_user
    @glider_flight = current_user.glider_flights.find_by(id: params[:id])
    redirect_to root_url if @glider_flight.nil?
  end
end
