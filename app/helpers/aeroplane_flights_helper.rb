module AeroplaneFlightsHelper
  # 飛行機の総飛行時間を計算
  def aeroplane_total_flight_time(attribute)
    all_flights = current_user.aeroplane_flights
    flight_info = init_aeroplane_experience('with_initial')
    flight_info = aeroplane_time_calculation(all_flights, flight_info)
    if attribute == :number_of_takeoff || attribute == :number_of_landing
      flight_info[attribute]
    else
      show_flight_time(flight_info[attribute])
    end
  end

  # 1フライト毎のフライトタイムを計算
  def aeroplane_each_flight_time(target_flight)
    target_flight.stop_time - target_flight.moving_time
  end
  # フライトタイムを「◯◯：◯◯」形式でビューに表示する
  def show_flight_time(time)
    hour = time.div(3600)
    min = (time % 3600) / 60
    "#{hour}:#{format('%02d', min)}"
  end

  # ページ毎のフライトタイム合計を計算する
  def aeroplane_page_total(which_page)
    current_page = @aeroplane_flights.current_page
    last_page = @aeroplane_flights.total_pages
    target_flights = []
    # 「ページ小計」
    case which_page
    when 'page_total'
      if current_page == last_page
        total_flights = current_user.aeroplane_flights.count
        target_num = total_flights % 10
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: total_flights - n))
        end
        flight_info = init_aeroplane_experience('without_initial')
        aeroplane_time_calculation(target_flights, flight_info)
      else
        flight_info = init_aeroplane_experience('without_initial')
        aeroplane_time_calculation(@aeroplane_flights, flight_info)
      end
    # 前ページまでの合計
    when 'up_to_before_current_page'
      if current_page != 1
        target_num = (current_page - 1) * 10
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: target_num - n))
        end
        flight_info = init_aeroplane_experience('with_initial')
        aeroplane_time_calculation(target_flights, flight_info)
      else
        init_aeroplane_experience('with_initial')
      end
    # 合計
    when 'all_pages'
      if current_page != 1
        # 最終ページの場合は端数を計算してtarget_numに代入
        target_num = current_page != last_page ? current_page * 10 : current_user.aeroplane_flights.count
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: target_num - n))
        end
        flight_info = init_aeroplane_experience('with_initial')
        aeroplane_time_calculation(target_flights, flight_info)
      elsif current_page == 1
        flight_info = init_aeroplane_experience('with_initial')
        aeroplane_time_calculation(@aeroplane_flights, flight_info)
      end
    end
  end

  def init_aeroplane_experience(with_or_without)
    initial_log = current_user.aeroplane_initial_log
    case with_or_without
    when 'without_initial'
      { total_time: 0,
        pic_time: 0,
        solo_time: 0,
        cross_country_time: 0,
        night_time: 0,
        dual_time: 0,
        dual_crosss_country_time: 0,
        dual_night_time: 0,
        hood_time: 0,
        instrument_time: 0,
        simulator_time: 0,
        instructor_time: 0,
        number_of_takeoff: 0,
        number_of_landing: 0 }
    when 'with_initial'
      { total_time: initial_log.total_time,
        pic_time: initial_log.pic_time,
        solo_time: initial_log.solo_time,
        cross_country_time: initial_log.cross_country_time,
        night_time: initial_log.night_time,
        dual_time: initial_log.dual_time,
        dual_crosss_country_time: initial_log.dual_crosss_country_time,
        dual_night_time: initial_log.dual_night_time,
        hood_time: initial_log.hood_time,
        instrument_time: initial_log.instrument_time,
        simulator_time: initial_log.simulator_time,
        instructor_time: initial_log.instructor_time,
        number_of_takeoff: initial_log.number_of_takeoff,
        number_of_landing: initial_log.number_of_landing }
    end
  end

  def aeroplane_time_calculation(targets, flight_info)
    targets.each do |target|
      target_flight_time = target.stop_time - target.moving_time

      flight_info[:total_time] += target_flight_time
      flight_info[:pic_time] += target_flight_time if target.is_pic?
      flight_info[:solo_time] += target_flight_time if !target.is_pic? && !target.is_dual?
      flight_info[:cross_country_time] += target_flight_time if target.is_pic? && target.is_cross_country?
      flight_info[:night_time] += target_flight_time if target.is_pic? && target.is_night_flight?
      flight_info[:dual_time] += target_flight_time if target.is_dual?
      flight_info[:dual_crosss_country_time] += target_flight_time if target.is_dual? && target.is_cross_country?
      flight_info[:dual_night_time] += target_flight_time if target.is_dual? && target.is_night_flight?
      flight_info[:hood_time] += target_flight_time if target.is_hood?
      flight_info[:instrument_time] += target_flight_time if target.is_instrument?
      flight_info[:simulator_time] += target_flight_time if target.is_simulator?
      flight_info[:instructor_time] += target_flight_time if target.is_instructor?
      flight_info[:number_of_takeoff] += target.number_of_takeoff
      flight_info[:number_of_landing] += target.number_of_landing
    end
    flight_info
  end
end
