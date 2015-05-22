FactoryGirl.define do
  factory :user do
    name "Douglas Adams"
    sequence(:email, 100) { |n| "person#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
    factory :user_with_post_and_comment do
      transient do
        posts_count 1
        comments_count 1
      end
      after(:build) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
        create_list(:comment, evaluator.comments_count, user: user)
      end
    end
  end
end

FactoryGirl.define do
  factory :post do
    title "Post Title"
    body "Post bodies must be pretty long."
    user
    topic { Topic.create(name: 'Topic name') }
  end
end

FactoryGirl.define do
  factory :comment do
    body "This is a new comment."
    user
    post

    after(:build) do |comment|
      comment.class.skip_callback(:create, :after, :send_favorite_emails)
    end
  end
end

