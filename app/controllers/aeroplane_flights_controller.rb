class AeroplaneFlightsController < ApplicationController
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

  private

  def aeroplane_flight_params
    params.require(:aeroplane_flight).permit(:departure_date, :aeroplane_type, :aeroplane_ident, :moving_time, :stop_time)
  end
end
