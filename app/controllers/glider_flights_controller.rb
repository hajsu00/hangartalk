class GliderFlightsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @glider_flight = GliderFlight.new
  end

  def create
    # glider_flight_params.merge(log_number: log_number)
    @glider_flight = current_user.glider_flights.build(glider_flight_params)
    if @glider_flight.save
      flash[:success] = "フライトログの登録に成功しました！"
      redirect_to root_url
    else
      flash[:danger] = "フライトログの登録に失敗しました。"
      render 'glider_flights/new'
    end
  end

  def show
  end

  def index
    @glider_flights = GliderFlight.where("user_id = ?", current_user.id).page(params[:page]).per(10)
  end

  def destroy
    deleted_lognumber = @glider_flights.log_number
    @glider_flights.destroy
    glider_flights = GliderFlight.where("user_id = ?", current_user.id).offset(deleted_lognumber - 1)
    new_log_number = deleted_lognumber
    glider_flights.each do |glider_flight|
      
      # glider_flight[:log_number] = n
      glider_flight.update(log_number: new_log_number)
      new_log_number += 1
    end
    flash[:success] = "選択したフライトログを削除しました。"
    redirect_to request.referrer || root_url
  end

  # 新しいフライト登録時のlog_numberを計算する
  def log_number
    # 離陸時間が末尾の離陸時間よりも新しい場合
    inputed_takeoff_time = params[:takeoff_time]
    inputed_date = params[:takeoff_time]
    glider_flights = GliderFlight.where("user_id = ?", current_user.id)
    glider_flights.last.daate

    binding.pry
    
    # if glider_flights.last.takeoff_time < inputed_takeoff_time
    # GliderFlight.where("user_id = ?", current_user.id).count + 1
    # '離陸時間がlog_number 1番〜末尾の間にある場合'
    # elsif ''
    # else
    #   # 1番より前の場合はエラーを出して入力画面に戻る
    # end
  end

  private

  def glider_flight_params
    params.require(:glider_flight).permit(:log_number, :departure_date, :glider_type, :glider_ident, :departure_and_arrival_point, :number_of_landing, :takeoff_time, :landing_time, :is_pic, :is_dual, :is_motor_glider, :is_power_flight, :is_winch, :is_cross_country, :is_instructor, :is_stall_recovery, :close_log, :note)
  end

  def correct_user
    @glider_flights = current_user.glider_flights.find_by(id: params[:id])
    redirect_to root_url if @glider_flights.nil?
  end
end
