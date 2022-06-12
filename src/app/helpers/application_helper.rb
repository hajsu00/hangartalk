module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Hanger Talk"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  # フライトタイムを「◯◯：◯◯」形式でビューに表示する
  def show_flight_time(time)
    hour = time.div(3600)
    min = (time % 3600) / 60
    "#{hour} + #{format('%02d', min)}"
  end

  def show_aircraft_type(aircraft_id)
    AircraftType.find(aircraft_id).aircraft_type
  end

  # 離陸/離脱/着陸時刻の日付をユーザーが入力した日付に合わせる
  def fix_inputed_time(model_name, column_name)
    inputed_time = Time.zone.parse(params[model_name][column_name])
    inputed_date = Date.parse(params[model_name][:date])
    Time.local(inputed_date.year, inputed_date.month, inputed_date.day, inputed_time.hour, inputed_time.min, 0, 0)
  end

  def total_flight_time(user)
    @target_total_time = user.glider_initial_log.total_time
    target_flights = user.glider_flights
    target_flights.each do |glider_flight|
      @target_total_time += glider_flight.landing_time - glider_flight.takeoff_time
    end
    show_flight_time(@target_total_time)
  end

  def total_flight_number(user)
    target_total_number = user.glider_initial_log.total_number
    target_flights = user.glider_flights
    target_total_number + target_flights.count
  end

  def glider_group_flight(target_flight)
    target_flight.landing_time - target_flight.takeoff_time
  end
end
