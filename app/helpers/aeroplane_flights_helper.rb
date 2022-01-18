module AeroplaneFlightsHelper
  def aeroplane_total_flight_time
    aeroplane_flight = @user.aeroplane_flights.find_by(id: @user.id)
    
  end
end
