FactoryBot.define do
  factory :fleet do
    ident { "MyString" }
    aircraft_type { 1 }
    group { nil }
  end
end
