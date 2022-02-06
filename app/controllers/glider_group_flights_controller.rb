class GliderGroupFlightsController < ApplicationController
  include GroupsHelper
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def new
    current_group = Group.find_by(params[:id])
    @glider_group_flight = current_group.glider_group_flights.build
  end

  def create
    current_group = Group.find_by(params[:id])
    @glider_group_flight = current_group.glider_group_flights.build(glider_group_flight_params)
    if @glider_group_flight.save
      redirect_to glider_group_flights_path(id: current_group.id), notice: 'フライト記録を登録しました'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
    @current_group = Group.find_by(params[:id])
    @glider_group_flights = GliderGroupFlight.where("group_id = ?", params[:id])
  end

  def destroy
  end

  private

  def glider_group_flight_params
    params.require(:glider_group_flight).permit(:day_flight_number, :date, :departure_and_arrival_point, :is_winch, :glider_type, :glider_ident, :front_seat, :front_flight_role, :rear_seat, :rear_flight_role, :takeoff_time, :release_time, :landing_time, :release_alt, :creator, :updater, :notes)
  end

  # def correct_user
  #   @glider_group_flights = current_user.microposts.find_by(id: params[:id])
  #   redirect_to root_url if @glider_group_flights.nil?
  # end
end
