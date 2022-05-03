FactoryBot.define do
  factory :license do
    license_code { "MyString" }
    license_category { 1 }
    date_of_issue { "2022-04-13" }
    user { nil }
  end
end
