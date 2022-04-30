# FactoryBot.define do
#   # factory :glider_flight do
#   #   log_number { 1 }
#   #   departure_date { "2022-01-30" }
#   #   aeroplane_type { "MyString" }
#   #   aeroplane_ident { "MyString" }
#   #   departure_point { "MyString" }
#   #   arrival_point { "MyString" }
#   #   number_of_landing { 1 }
#   #   takeoff_time { "2022-01-30 11:10:08" }
#   #   landing_time { "2022-01-30 11:10:08" }
#   #   is_pic { false }
#   #   is_dual { false }
#   #   is_cross_country { false }
#   #   is_instructor { false }
#   #   is_stall_recovery { false }
#   #   note { "MyString" }
#   #   user { nil }
#   # end
#   factory :glider_flight do
#     association :user

#     takeoff_time = Time.current + ((n + 1) * 60).minutes
#     departure_date = Date.new(takeoff_time.year, takeoff_time.month, takeoff_time.day)
#     landing_time = takeoff_time + 6.minutes

#     log_number { |n| "#{n}" }
#     departure_date { departure_date }
#     aeroplane_type { n.even? ? "ASK23" : "ASK21" }
#     aeroplane_ident { n.even? ? "JA2381" : "JA21MA" }
#     departure_and_arrival_point { "宝珠花滑空場" }
#     number_of_landing { 1 }
#     takeoff_time { takeoff_time }
#     landing_time { landing_time }
#     flight_role { 
#       if n.even?
#         "単独飛行"
#       "同乗教育" }
#     is_cross_country { false }
#     is_instructor { false }
#     is_stall_recovery { n.even? ? false : true }
#     note { "備考欄です。" }
#     user { user }
#   end
# end
