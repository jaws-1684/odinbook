FactoryBot.define do
  factory :user, aliases: [:author] do
    full_name {"bot"}
    sequence(:email) { |n| "bot#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :with_friends do
      transient do
        friends { [] }
      end

      after(:create) do |user, context|
        context.friends.each { |f| create(:friend_request, :accepted, user: user, friend: f) }
      end
    end

    trait :with_sent_invitations do
      transient do
        invitees { [] }
      end

      after(:create) do |user, context|
        context.invitees.each { |f| create(:friend_request, :sent, user: user, friend: f) }
      end
    end

    trait :with_received_invitations do
      transient do
        invitators { [] }
      end

      after(:create) do |user, context|
        context.invitators.each { |f| create(:friend_request, :received, user: f, friend: user) }
      end
    end
    
    trait :with_posts do
        after(:create) { |user| create( :post, user: user) }
    end
    trait :with_post_comments do
      transient do
        commentable_type { }
      end
        after(:create) { |user, context| create( :comment, user: user, commentable: context.commentable_type) }
    end
  end
end
