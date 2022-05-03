FactoryBot.define do
  factory :aeroplane_leg do
    departure_point { "MyString" }
    arrival_point { "MyString" }
    takeoff_time { "2022-01-20 14:13:21" }
    landing_time { "2022-01-20 14:13:21" }
    number_of_landing { "" }
    aeroplane_flight { nil }
  end
end
