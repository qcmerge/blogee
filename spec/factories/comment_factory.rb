FactoryGirl.define do
  factory :comment do
    sequence(:author) { |n| "Randy #{n} Savage" }
    content "Lorem ipsum dolor site amet"
  end
end
