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

  def total_flight_time
    @total_time = @initial_flight_time
    @all_glider_flights.each do |glider_flight|
      @total_time += glider_flight.landing_time - glider_flight.takeoff_time
    end
    show_flight_time(@total_time)
  end
  def total_flight_number
    @initial_flight_number + @all_glider_flights.count
  end
end
