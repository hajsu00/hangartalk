FactoryBot.define do
  factory :glider_initial_log do
    user
    at_present  { Date.today }
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
