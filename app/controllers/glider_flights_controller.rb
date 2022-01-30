class GliderFlightsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @glider_flight = AeroplaneFlight.new
  end

  def create
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

  private

  def glider_flight_params
    params.require(:glider_flight).permit(:log_number, :departure_date, :glider_type, :glider_ident, :departure_point, :arrival_point, :number_of_landing, :takeoff_time, :landing_time, :is_pic, :is_dual, :is_motor_glider, :is_power_flight, :is_winch, :is_cross_country, :is_instructor, :is_stall_recovery, :close_log, :note)
  end
end
