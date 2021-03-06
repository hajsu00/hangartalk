module GliderFlightsHelper
  # グループから取得したフライトがすでにログブックに記載されていた場合、trueを返す
  def match_takeoff_time?(glider_flight, logged_flights)
    logged_flights.each do |logged_flight|
      return true if logged_flight.takeoff_time == glider_flight.takeoff_time
    end
    false
  end

  # showページ用
  def show_flight_info(flag, category)
    case category
    when 'winch'
      flag == true ? 'ウインチ曳航' : '航空機曳航'
    when 'instructor'
      '操縦教員としてのフライト' if flag == true
    when 'cross_country'
      '野外飛行' if flag == true
    end
  end

  # ログNo.を新しくふり直す
  def new_log_number
    glider_flights = GliderFlight.where("user_id = ?", current_user.id).order(date: :asc, takeoff_time: :asc)
    n = 1
    glider_flights.each do |glider_flight|
      glider_flight.update_attribute(:log_number, n)
      n += 1
    end
  end

  # 飛行機の総飛行時間を計算
  def glider_total_flight_time(attribute)
    all_flights = current_user.glider_flights
    flight_info = init_glider_experience('with_initial')
    flight_info = glider_time_calculation(all_flights, flight_info)
    if attribute == :total_number
      flight_info[attribute]
    else
      show_flight_time(flight_info[attribute])
    end
  end

  # 1フライト毎のフライトタイムを計算
  def glider_each_flight_time(target_flight)
    target_flight.landing_time - target_flight.takeoff_time
  end

  # ページ毎のフライトタイム合計を計算する
  def glider_page_total(which_page)
    current_page = @logbook_flights.current_page
    last_page = @logbook_flights.total_pages
    target_flights = []
    # ページ小計
    case which_page
    when 'page_total'
      if current_page == last_page
        total_flights = @glider_flights.count
        target_num = total_flights % 10
        target_num.times do |n|
          target_flights.push(@glider_flights.find_by(log_number: total_flights - n))
        end
        flight_info = init_glider_experience('without_initial')
        glider_time_calculation(target_flights, flight_info)
      else
        10.times do |n|
          target_flights.push(@glider_flights.find_by(log_number: current_page * 10 - n))
        end
        flight_info = init_glider_experience('without_initial')
        glider_time_calculation(target_flights, flight_info)
      end
    # 前ページまでの合計
    when 'up_to_before_current_page'
      if current_page != 1
        target_num = (current_page - 1) * 10
        target_num.times do |n|
          target_flights.push(@glider_flights.find_by(log_number: target_num - n))
        end
        flight_info = init_glider_experience('with_initial')
        glider_time_calculation(target_flights, flight_info)
      else
        init_glider_experience('with_initial')
      end
    # 本ページまでの総合計
    when 'all_pages'
      if current_page != 1
        # 最終ページの場合は端数を計算してtarget_numに代入
        target_num = current_page != last_page ? current_page * 10 : @glider_flights.count
        target_num.times do |n|
          target_flights.push(@glider_flights.find_by(log_number: target_num - n))
        end
        flight_info = init_glider_experience('with_initial')
        glider_time_calculation(target_flights, flight_info)
      elsif current_page == 1
        10.times do |n|
          target_flights.push(@glider_flights.find_by(log_number: current_page * 10 - n))
        end
        flight_info = init_glider_experience('with_initial')
        glider_time_calculation(target_flights, flight_info)
      end
    end
  end

  def init_glider_experience(with_or_without)
    initial_flight_log = current_user.glider_initial_log
    if !initial_flight_log.nil?
      case with_or_without
      when 'without_initial'
        { total_time: 0,
          total_number: 0,
          pic_winch_time: 0,
          pic_winch_number: 0,
          pic_aero_tow_time: 0,
          pic_aero_tow_number: 0,
          solo_winch_time: 0,
          solo_winch_number: 0,
          solo_aero_tow_time: 0,
          solo_aero_tow_number: 0,
          dual_winch_time: 0,
          dual_winch_number: 0,
          dual_aero_tow_time: 0,
          dual_aero_tow_number: 0,
          cross_country_time: 0,
          instructor_time: 0,
          instructor_number: 0,
          number_of_stall_recovery: 0 }
      when 'with_initial'
        { total_time: initial_flight_log.total_time,
          total_number: initial_flight_log.total_number,
          pic_winch_time: initial_flight_log.pic_winch_time,
          pic_winch_number: initial_flight_log.pic_winch_number,
          pic_aero_tow_time: initial_flight_log.pic_aero_tow_time,
          pic_aero_tow_number: initial_flight_log.pic_aero_tow_number,
          solo_winch_time: initial_flight_log.solo_winch_time,
          solo_winch_number: initial_flight_log.solo_winch_number,
          solo_aero_tow_time: initial_flight_log.solo_aero_tow_time,
          solo_aero_tow_number: initial_flight_log.solo_aero_tow_number,
          dual_winch_time: initial_flight_log.dual_winch_time,
          dual_winch_number: initial_flight_log.dual_winch_number,
          dual_aero_tow_time: initial_flight_log.dual_aero_tow_time,
          dual_aero_tow_number: initial_flight_log.dual_aero_tow_number,
          cross_country_time: initial_flight_log.cross_country_time,
          instructor_time: initial_flight_log.instructor_time,
          instructor_number: initial_flight_log.instructor_number,
          number_of_stall_recovery: initial_flight_log.number_of_stall_recovery }
      end
    else
      { total_time: 0,
        total_number: 0,
        pic_winch_time: 0,
        pic_winch_number: 0,
        pic_aero_tow_time: 0,
        pic_aero_tow_number: 0,
        solo_winch_time: 0,
        solo_winch_number: 0,
        solo_aero_tow_time: 0,
        solo_aero_tow_number: 0,
        dual_winch_time: 0,
        dual_winch_number: 0,
        dual_aero_tow_time: 0,
        dual_aero_tow_number: 0,
        cross_country_time: 0,
        instructor_time: 0,
        instructor_number: 0,
        number_of_stall_recovery: 0 }
    end
  end

  def glider_time_calculation(targets, flight_info)
    targets.each do |target|
      target_flight_time = target.landing_time - target.takeoff_time

      # 滑空機による時間
      flight_info[:total_time] += target_flight_time
      flight_info[:total_number] += 1
      case target.flight_role
      when '機長'
        if target.is_winch?
          flight_info[:pic_winch_time] += target_flight_time
          flight_info[:pic_winch_number] += 1
        else
          flight_info[:pic_aero_tow_time] += target_flight_time
          flight_info[:pic_aero_tow_number] += 1
        end
      when '単独飛行'
        if target.is_winch?
          flight_info[:solo_winch_time] += target_flight_time
          flight_info[:solo_winch_number] += 1
        else
          flight_info[:solo_aero_tow_time] += target_flight_time
          flight_info[:solo_aero_tow_number] += 1
        end
      when '同乗教育'
        if target.is_winch?
          flight_info[:dual_winch_time] += target_flight_time
          flight_info[:dual_winch_number] += 1
        else
          flight_info[:dual_aero_tow_time] += target_flight_time
          flight_info[:dual_aero_tow_number] += 1
        end
      end
      # その他の飛行時間
      if target.is_instructor?
        flight_info[:instructor_time] += target_flight_time
        flight_info[:instructor_number] += 1
      end
      flight_info[:cross_country_time] += target_flight_time if target.is_cross_country?
      flight_info[:number_of_stall_recovery] += 1 if target.is_stall_recovery?
    end
    flight_info
  end
end
