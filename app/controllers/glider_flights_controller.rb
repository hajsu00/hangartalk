class GliderFlightsController < ApplicationController
  include SessionsHelper
  include GliderFlightsHelper
  include ApplicationHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @glider_flight = GliderFlight.new
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  def create
    @glider_flight = current_user.glider_flights.build(glider_flight_params)
    if @glider_flight.save
      glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(takeoff_time: :asc)
      new_log_number(glider_flights)
      flash[:success] = "フライトログの登録に成功しました！"
      redirect_to glider_flights_url
    else
      flash[:danger] = "フライトログの登録に失敗しました。"
      render 'glider_flights/new'
    end
  end

  def show
    @glider_flight = GliderFlight.find_by(id: params[:id])
  end

  def edit
    @glider_flight = GliderFlight.find_by(id: params[:id])
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  def update
    @glider_flight = GliderFlight.find_by(id: params[:id])
    if @glider_flight.update(glider_flight_params)
      glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(takeoff_time: :asc)
      new_log_number(glider_flights)
      flash[:success] = "フライトログの更新に成功しました！"
      redirect_to glider_flights_url
    else
      flash[:danger] = "フライトログの更新に失敗しました。"
      render 'glider_flights/edit'
    end
  end

  def index
    @glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(log_number: :asc).page(params[:page]).per(10)
    @glider_initial_log = current_user.glider_initial_log
  end

  def destroy
    @glider_flight.destroy
    glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(log_number: :asc)
    new_log_number(glider_flights)
    flash[:success] = "選択したフライトログを削除しました。"
    redirect_to request.referrer || root_url
  end

  def new_from_groups
    set_values
  end

  def create_from_groups
    @glider_flights = Form::GliderFlightCollection.new(new_from_groups_params, current_user, 'create')
    if @glider_flights.save_collection
      glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(takeoff_time: :asc)
      new_log_number(glider_flights)
      flash[:success] = "グループフライトからのログ取得に成功しました！"
      @glider_type = AircraftType.where("category = ?", 'glider')
      redirect_to glider_flights_url
    else
      flash[:danger] = "グループフライトからのログ取得に失敗しました。"
      set_values
      render :new_from_groups
    end
  end

  def set_values
    @logged_flights = GliderFlight.where("user_id = ?", current_user.id)
    @flights_from_groups = GliderGroupFlight.where("front_seat = ? OR rear_seat = ?", current_user.id, current_user.id)
    @glider_flights = Form::GliderFlightCollection.new(@flights_from_groups, current_user, 'new')
    @glider_type = AircraftType.where("category = ?", 'glider')
  end

  private

  def glider_flight_params
    # チェックボックスがアンチェック時にnilではなくfalseを代入する
    params[:glider_flight][:takeoff_time] = fix_inputed_time(:glider_flight, :takeoff_time)
    params[:glider_flight][:landing_time] = fix_inputed_time(:glider_flight, :landing_time)
    params[:glider_flight][:is_motor_glider] = false if params[:glider_flight][:is_motor_glider].nil?
    params[:glider_flight][:is_power_flight] = false if params[:glider_flight][:is_power_flight].nil?
    params[:glider_flight][:is_cross_country] = false if params[:glider_flight][:is_cross_country].nil?
    params[:glider_flight][:is_instructor] = false if params[:glider_flight][:is_instructor].nil?
    params[:glider_flight][:is_stall_recovery] = false if params[:glider_flight][:is_stall_recovery].nil?
    params[:glider_flight][:close_log] = false if params[:glider_flight][:close_log].nil?
    # ストロングパラメーターの設定
    params.require(:glider_flight).permit(:log_number, :date, :glider_type, :glider_ident, :departure_and_arrival_point, :number_of_landing, :takeoff_time, :landing_time, :release_alt, :flight_role, :is_motor_glider, :is_power_flight, :is_winch, :is_cross_country, :is_instructor, :is_stall_recovery, :close_log, :note)
  end

  def new_from_groups_params
    # binding.pry
    # params = params[:glider_flights]
    # params.each do |param|
    #   binding.pry
    #   param.takeoff_time = fix_inputed_time(:glider_flight, :takeoff_time)
    #   param.landing_time = fix_inputed_time(:glider_flight, :landing_time)
    #   param.is_motor_glider = false if param.is_motor_glider.nil?
    #   param.is_power_flight = false if param.is_power_flight.nil?
    #   param.is_cross_country = false if param.is_cross_country.nil?
    #   param.is_instructor = false if param.is_instructor.nil?
    #   param.is_stall_recovery = false if param.is_stall_recovery.nil?
    #   param.close_log = false if param.close_log.nil?
    # end
    # binding.pry
    # params.require(:glider_flights).permit(:date, :glider_type, :glider_ident, :departure_and_arrival_point, :number_of_landing, :takeoff_time, :landing_time, :release_alt, :flight_role, :is_winch, :note)
    params.require(:glider_flights)
  end

  def correct_user
    @glider_flight = current_user.glider_flights.find_by(id: params[:id])
    redirect_to root_url if @glider_flight.nil?
  end
end
