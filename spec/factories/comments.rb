FactoryBot.define do
  factory :comment do
    association :user
    for_post
    body { "I am a comment i am not to long but still" }
    trait :for_post do
      association :commentable, factory: :post
    end
  end
end
