FactoryBot.define do
  factory :aircraft_type do
    sequence(:aircraft_type, "ASK_1")
    category { "glider" }
  end
end
