module AeroplaneFlightsHelper
  # ユーザーのフライトログ（飛行機）を取得
  def setup_user_flight
    @user = User.find_by(id: current_user.id)
    @flights = @user.aeroplane_flights
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
    #setup_user_flight
    #@aeroplane_flights.count
    current_user.aeroplane_flights.count
  end

  # 1フライト毎のフライトタイムを計算
  def aeroplane_each_flight_time(target_flight)
    flight_hour = target_flight.stop_time.hour - target_flight.moving_time.hour
    flight_min = target_flight.stop_time.min - target_flight.moving_time.min
    [formt_time(flight_hour, flight_min)[:hour], formt_time(flight_hour, flight_min)[:min]]
  end
  # フライトタイムを「◯◯：◯◯」形式でビューに表示する
  def show_flight_time(hour, min)
    formt_time(hour, min)
    "#{formt_time(hour, min)[:hour]}:#{format('%02d', formt_time(hour, min)[:min])}"
  end
  # 時刻表示のフォーマットを整える
  def formt_time(hour, min)
    if min.negative?
      hour -= 1
      min = 60 + min
    elsif min > 60
      hour += min.div(60)
      min -= 60 * min.div(60)
    end
    { hour: hour, min: min }
  end

  # ページ毎のフライトタイム合計を計算する
  def page_total_time(which_page)
    setup_user_flight
    last_flight_log_number = @aeroplane_flights.last.log_number
    number_of_last_page_flights = last_flight_log_number % 10
    case which_page
    when 'current_page'
      number_of_target_flights = number_of_last_page_flights
      flight_time = total_time_calculation(number_of_target_flights, last_flight_log_number)
    when 'up_to_previous_page'
      flight_time = total_time_calculation(10, last_flight_log_number - number_of_last_page_flights)
    when 'all_page'
      flight_time = total_time_calculation(last_flight_log_number, last_flight_log_number)
    end
    flight_time
  end
  # フライトタイム計算部分
  def total_time_calculation(number_of_target, starts_from)
    flight_time = {
      total_time: { hour: 0, min: 0 },
      pic_time: { hour: 0, min: 0 },
      solo_time: { hour: 0, min: 0 },
      cross_country_time: { hour: 0, min: 0 },
      night_time: { hour: 0, min: 0 },
      dual_time: { hour: 0, min: 0 },
      dual_crosss_country_time: {hour: 0, min: 0 },
      dual_night_time: { hour: 0, min: 0 },
      hood_time: { hour: 0, min: 0 },
      instrument_time: { hour: 0, min: 0 },
      simlator_time: { hour: 0, min: 0 },
      instructor_time: { hour: 0, min: 0 },
    }
    (0..(number_of_target - 1)).each do |n|
      target_flight = @aeroplane_flights.find_by(log_number: starts_from - n)
      target_flight_time = aeroplane_each_flight_time(target_flight)
      if target_flight.is_pic?
        flight_time[:pic_time][:hour] += target_flight_time[0]
        flight_time[:pic_time][:min] += target_flight_time[1]
      end
      if !target_flight.is_pic? && !target_flight.is_dual?
        flight_time[:solo_time][:hour] += target_flight_time[0]
        flight_time[:solo_time][:min] += target_flight_time[1]
      end
      if target_flight.is_pic? && target_flight.is_cross_country?
        flight_time[:cross_country_time][:hour] += target_flight_time[0]
        flight_time[:cross_country_time][:min] += target_flight_time[1]
      end
      if target_flight.is_pic? && target_flight.is_night_flight?
        flight_time[:night_time][:hour] += target_flight_time[0]
        flight_time[:night_time][:min] += target_flight_time[1]
      end
      if target_flight.is_dual?
        flight_time[:dual_time][:hour] += target_flight_time[0]
        flight_time[:dual_time][:min] += target_flight_time[1]
      end
      if target_flight.is_dual? && target_flight.is_cross_country?
        flight_time[:dual_crosss_country_time][:hour] += target_flight_time[0]
        flight_time[:dual_crosss_country_time][:min] += target_flight_time[1]
      end
      if target_flight.is_dual? && target_flight.is_night_flight?
        flight_time[:dual_night_time][:hour] += target_flight_time[0]
        flight_time[:dual_night_time][:min] += target_flight_time[1]
      end
      if target_flight.is_hood?
        flight_time[:hood_time][:hour] += target_flight_time[0]
        flight_time[:hood_time][:min] += target_flight_time[1]
      end
      if target_flight.is_instrument?
        flight_time[:instrument_time][:hour] += target_flight_time[0]
        flight_time[:instrument_time][:min] += target_flight_time[1]
      end
      if target_flight.is_simulator?
        flight_time[:simlator_time][:hour] += target_flight_time[0]
        flight_time[:simlator_time][:min] += target_flight_time[1]
      end
      if target_flight.is_instructor?
        flight_time[:instructor_time][:hour] += target_flight_time[0]
        flight_time[:instructor_time][:min] += target_flight_time[1]
      end
      flight_time[:total_time][:hour] += target_flight_time[0]
      flight_time[:total_time][:min] += target_flight_time[1]
    end
    flight_time
  end
end
