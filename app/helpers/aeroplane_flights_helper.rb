module AeroplaneFlightsHelper
  # 飛行機の総飛行時間を計算
  def aeroplane_total_flight_time
    all_flights = current_user.aeroplane_flights
    flight_time = total_time_calculation(all_flights)
    show_flight_time(flight_time[:total_time])
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
  def page_total_time(which_page)
    current_page = @aeroplane_flights.current_page
    target_flights = []
    # 「ページ小計」
    case which_page
    when 'current_page'
      last_page = @aeroplane_flights.total_pages
      if current_page == last_page
        total_flights = current_user.aeroplane_flights.count
        target_num = total_flights % 10
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: total_flights - n))
        end
        total_time_calculation(target_flights)
      else
        total_time_calculation(@aeroplane_flights)
      end
    # 前ページまでの合計
    when 'up_to_before_current_page'
      if current_page != 1
        target_num = (current_page - 1) * 10
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: target_num - n))
        end
        total_time_calculation(target_flights)
      end
    # 合計
    when 'all_pages'
      if current_page != 1
        # 最終ページの場合は端数を計算してtarget_numに代入
        target_num = current_page != 3 ? current_page * 10 : current_user.aeroplane_flights.count
        target_num.times do |n|
          target_flights.push(current_user.aeroplane_flights.find_by(log_number: target_num - n))
        end
        total_time_calculation(target_flights)
      elsif current_page == 1
        total_time_calculation(@aeroplane_flights)
      end
    end
  end

  def total_time_calculation(targets)
    flight_time = {
      total_time: 0,
      pic_time: 0,
      solo_time: 0,
      cross_country_time: 0,
      night_time: 0,
      dual_time: 0,
      dual_crosss_country_time: 0,
      dual_night_time: 0,
      hood_time: 0,
      instrument_time: 0,
      simlator_time: 0,
      instructor_time: 0
    }
    targets.each do |target|
      target_flight_time = target.stop_time - target.moving_time

      flight_time[:pic_time] += target_flight_time if target.is_pic?
      flight_time[:solo_time] += target_flight_time if !target.is_pic? && !target.is_dual?
      flight_time[:cross_country_time] += target_flight_time if target.is_pic? && target.is_cross_country?
      flight_time[:night_time] += target_flight_time if target.is_pic? && target.is_night_flight?
      flight_time[:dual_time] += target_flight_time if target.is_dual?
      flight_time[:dual_crosss_country_time] += target_flight_time if target.is_dual? && target.is_cross_country?
      flight_time[:dual_night_time] += target_flight_time if target.is_dual? && target.is_night_flight?
      flight_time[:hood_time] += target_flight_time if target.is_hood?
      flight_time[:instrument_time] += target_flight_time if target.is_instrument?
      flight_time[:simlator_time] += target_flight_time if target.is_simulator?
      flight_time[:instructor_time] += target_flight_time if target.is_instructor?

      flight_time[:total_time] += target_flight_time
    end
    flight_time
  end
end
