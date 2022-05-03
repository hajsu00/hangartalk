FactoryBot.define do
  factory :reply_relationship do
    main_micropost { nil }
    reply_micropost { nil }
  end
end
