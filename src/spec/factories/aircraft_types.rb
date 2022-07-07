FactoryBot.define do
  factory :aircraft_type do
    sequence(:aircraft_type) { |n| "ASK_#{n}" }
    category { "glider" }
  end
end
