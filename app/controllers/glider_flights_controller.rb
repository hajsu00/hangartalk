class GliderFlightsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @glider_flight = GliderFlight.new
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
  end

  def destroy
    @glider_flights.destroy
    glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(log_number: :asc)
    new_log_number(glider_flights)
    flash[:success] = "選択したフライトログを削除しました。"
    redirect_to request.referrer || root_url
  end
  # 指定フライト以降のログNo.を新しくふり直す
  def new_log_number(flights)
    n = 1
    flights.each do |flight|
      flight.update(log_number: n)
      n += 1
    end
  end

  # 離陸時刻の日付をユーザーが入力した日付に合わせる
  def fix_inputed_time(attribute)
    inputed_time = Time.parse(params[:glider_flight][attribute])
    inputed_date = Date.parse(params[:glider_flight][:date])
    Time.local(inputed_date.year, inputed_date.month, inputed_date.day, inputed_time.hour, inputed_time.min, 0, 0)
  end

  private

  def glider_flight_params
    # チェックボックスがアンチェック時にnilではなくfalseを代入する
    params[:glider_flight][:takeoff_time] = fix_inputed_time(:takeoff_time)
    params[:glider_flight][:landing_time] = fix_inputed_time(:landing_time)
    params[:glider_flight][:is_motor_glider] = false if params[:glider_flight][:is_motor_glider].nil?
    params[:glider_flight][:is_power_flight] = false if params[:glider_flight][:is_power_flight].nil?
    params[:glider_flight][:is_cross_country] = false if params[:glider_flight][:is_cross_country].nil?
    params[:glider_flight][:is_instructor] = false if params[:glider_flight][:is_instructor].nil?
    params[:glider_flight][:is_stall_recovery] = false if params[:glider_flight][:is_stall_recovery].nil?
    params[:glider_flight][:close_log] = false if params[:glider_flight][:close_log].nil?
    # ストロングパラメーターの設定
    params.require(:glider_flight).permit(:log_number, :date, :glider_type, :glider_ident, :departure_and_arrival_point, :number_of_landing, :takeoff_time, :landing_time, :release_alt, :flight_role, :is_motor_glider, :is_power_flight, :is_winch, :is_cross_country, :is_instructor, :is_stall_recovery, :close_log, :note)
  end

  def correct_user
    @glider_flights = current_user.glider_flights.find_by(id: params[:id])
    redirect_to root_url if @glider_flights.nil?
  end
end
