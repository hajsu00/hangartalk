FactoryBot.define do
  factory :glider_group_flight do
    date { "2022-02-03" }
    place { "MyString" }
    is_winch { false }
    is_motor_glider { false }
    fleet { "MyString" }
    front_seat { "MyString" }
    is_front_pic { false }
    is_front_solo { false }
    is_front_dual { false }
    is_front_instructor { false }
    is_front_guest { false }
    rear_seat { "MyString" }
    is_rear_pic { false }
    is_rear_dual { false }
    is_rear_instructor { false }
    is_rear_guest { false }
    takeoff_time { "2022-02-03 15:06:11" }
    release_time { "2022-02-03 15:06:11" }
    landing_time { "2022-02-03 15:06:11" }
    release_alt { 1 }
    creator { "MyString" }
    updater { "MyString" }
    notes { "MyString" }
    group { nil }
  end
end
