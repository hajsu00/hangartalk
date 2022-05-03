FactoryBot.define do
  factory :glider_flight do
    # association :user

    date { "2022-01-30" }
    sequence(:log_number) { |n| "#{n}" }
    glider_type { "ASK21" }
    glider_ident { "JA21MA" }
    departure_and_arrival_point { "宝珠花滑空場" }
    number_of_landing { 1 }
    takeoff_time { "2022-01-30 11:10:08" }
    landing_time { "2022-01-30 11:16:08" }
    flight_role { '機長' }
    is_winch { true }
    is_cross_country { false }
    release_alt { 400 }
    is_instructor { false }
    is_stall_recovery { false }
    note { "備考欄です。" }
    # user { user }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
