FactoryBot.define do
  factory :friend_request do
      association :user
      association :friend, factory: :user
      trait :accepted do
        status { 1 }
      end
      trait :sent do
        status { 0 }
      end
      trait :received do
        status { 0 }
      end
    end
end
