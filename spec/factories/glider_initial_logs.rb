FactoryBot.define do
  # factory :glider_initial_log do
  #   total_flight_number { 1 }
  #   number_of_landing { 1 }
  #   total_time { 1 }
  #   pic_winch_time { 1 }
  #   pic_aero_tow_time { 1 }
  #   dual_winch_time { 1 }
  #   dual_aero_tow_time { 1 }
  #   cross_country_time { 1 }
  #   number_of_stall_recovery { 1 }
  #   user { nil }
  # end

  factory :glider_initial_log do
    association :user

    at_present { "2022-01-30" }
    total_time { 0 }
    total_number { 0 }
    pic_winch_time { 0 }
    pic_winch_number { 0 }
    pic_aero_tow_time { 0 }
    pic_aero_tow_number { 0 }
    solo_winch_time { 0 }
    solo_winch_number { 0 }
    solo_aero_tow_time { 0 }
    solo_aero_tow_number { 0 }
    dual_winch_time { 0 }
    dual_winch_number { 0 }
    dual_aero_tow_time { 0 }
    dual_aero_tow_number { 0 }
    cross_country_time { 0 }
    instructor_time { 0 }
    instructor_number { 0 }
    number_of_stall_recovery { 0 }
  end
end
