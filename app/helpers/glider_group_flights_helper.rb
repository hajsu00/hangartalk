module GliderGroupFlightsHelper
  def day_flight_number
    1
  end

  def towing_way(target_flight)
    if target_flight.is_winch?
      'ウインチ曳航'
    else
      '航空機曳航'
    end
  end

  def show_user_name(name_id)
    User.find_by(id: name_id).name
  end
end
