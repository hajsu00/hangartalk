module AeroplaneFlightsHelper
  # ユーザーのフライトログ（飛行機）を取得
  def setup_user_flight
    @user = User.find_by(id: current_user.id)
    @aeroplane_flights = @user.aeroplane_flights
  end
  # 飛行機の総飛行時間を計算
  def aeroplane_total_flight_time
    setup_user_flight
    total_time = 0
    @aeroplane_flights.each do |aeroplane_flight|
      total_time += aeroplane_flight[:stop_time] - aeroplane_flight[:moving_time]
    end
    total_time /= 60
    "#{total_time.div(60)}時間#{(total_time % 60).round}分"
  end
  # 飛行機の総離着陸回数を計算
  def total_landing_number
    setup_user_flight
    @aeroplane_flights.count
  end

  def aeroplane_each_flight_time(target_flight)
    flight_hour = target_flight.stop_time.hour - target_flight.moving_time.hour
    flight_min = target_flight.stop_time.min - target_flight.moving_time.min
    if flight_min.negative?
      flight_hour -= 1
      flight_min = 60 + flight_min
    end
    "#{flight_hour}:#{format('%02d', flight_min)}"
  end
end
