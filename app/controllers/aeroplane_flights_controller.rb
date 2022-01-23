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
    # @aeroplane_flights = AeroplaneFlight.where("user_id = ?", current_user.id).page params[:page]
    # @aeroplane_flights = AeroplaneFlight.where("user_id = ?", current_user.id).page(params[:page]).per(10)
    @aeroplane_flights = AeroplaneFlight.where("user_id = ?", current_user.id).page(params[:page]).per(10)
    # @aeroplane_flights = @aeroplane_flights.page(params[:page]).per(10)
    
    # @aeroplane_flights = current_user.aeroplane_flights.build
    # @aeroplane_flights = AeroplaneFlight.page(:params[:page]).per(10)
    # @aeroplane_flights = @aeroplane_flights.page(:params[:page]).per(10)
  end

  private

  def aeroplane_flight_params
    params.require(:aeroplane_flight).permit(:departure_date, :aeroplane_type, :aeroplane_ident, :moving_time, :stop_time)
  end
end
