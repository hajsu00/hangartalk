class AeroplaneFlightsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @aeroplane_flight = AeroplaneFlight.new
  end

  def create
    @aeroplane_flight = current_user.aeroplane_flights.build(aeroplane_flight_params)
    if @aeroplane_flight.save
      flash[:success] = "フライトログの登録に成功しました！"
      redirect_to root_url
    else
      flash[:danger] = "フライトログの登録に失敗しました。"
      render 'aeroplane_flights/new'
    end
  end

  def show
  end

  def index
    @aeroplane_flights = AeroplaneFlight.where("user_id = ?", current_user.id).page(params[:page]).per(10)
  end

  private

  def aeroplane_flight_params
    # params.require(:aeroplane_flight).permit(:departure_date, :aeroplane_type, :aeroplane_ident, :moving_time, :stop_time)
    params.require(:aeroplane_flight).permit(:departure_date, :aeroplane_type, :aeroplane_ident, :departure_point, :arrival_point, :exercises_or_maneuvers, :number_of_takeoff, :number_of_landing, :moving_time, :stop_time, :is_pic, :is_dual, :is_cross_country, :is_night_flight, :is_hood, :is_instrument, :is_simulator, :is_instructor, :is_stall_recovery, :note)
  end
end
