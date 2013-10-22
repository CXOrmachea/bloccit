FactoryGirl.define do
  factory :comment do
    body "this is a new comment"
    user
    post
  end
end