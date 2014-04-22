FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    content 'Lorem ipsum dolor sit amet.'
    author 'Randy Savage'
  end
end
