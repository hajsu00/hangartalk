class AeroplaneFlightsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :select, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    @aeroplane_flight = AeroplaneFlight.new
    @aeroplane_type = AircraftType.where("category = ?", 'aeroplane')
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
    params.require(:aeroplane_flight).permit(:log_number, :date, :aeroplane_type, :aeroplane_ident, :departure_point, :arrival_point, :exercises_or_maneuvers,
                                             :number_of_takeoff, :number_of_landing, :moving_time, :stop_time, :flight_role, :is_cross_country, :is_night_flight, :is_hood, :is_instrument, :is_simulator, :is_instructor, :is_stall_recovery, :close_log, :note)
  end
end
