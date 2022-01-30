FactoryBot.define do
  factory :glider_initial_log do
    total_flight_number { 1 }
    number_of_landing { 1 }
    total_time { 1 }
    pic_winch_time { 1 }
    pic_aero_tow_time { 1 }
    dual_winch_time { 1 }
    dual_aero_tow_time { 1 }
    cross_country_time { 1 }
    number_of_stall_recovery { 1 }
    user { nil }
  end
end
