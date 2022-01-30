FactoryBot.define do
  factory :glider_flight do
    log_number { 1 }
    departure_date { "2022-01-30" }
    aeroplane_type { "MyString" }
    aeroplane_ident { "MyString" }
    departure_point { "MyString" }
    arrival_point { "MyString" }
    number_of_landing { 1 }
    takeoff_time { "2022-01-30 11:10:08" }
    landing_time { "2022-01-30 11:10:08" }
    is_pic { false }
    is_dual { false }
    is_cross_country { false }
    is_instructor { false }
    is_stall_recovery { false }
    note { "MyString" }
    user { nil }
  end
end
