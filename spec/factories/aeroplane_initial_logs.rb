FactoryBot.define do
  factory :aeroplane_initial_log do
    flight_hour { 1 }
    flight_min { 1 }
    number_of_takeoff { 1 }
    number_off_landing { 1 }
    pic_time { 1 }
    solo_time { 1 }
    xc_time { 1 }
    night_time { 1 }
    dual_time { 1 }
    dual_xc_time { 1 }
    dual_night_time { 1 }
    hood_time { 1 }
    instrument_time { 1 }
    simulator_time { 1 }
    instructor_time { 1 }
    user { nil }
  end
end
