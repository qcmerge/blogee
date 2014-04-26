FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) { |n| "bob#{n}@example.com" }
    password "mypassword"
  end
end
