FactoryGirl.define do
  factory :post do
    title 'My Post'
    content 'Lorem ipsum dolor sit amet.'
    author 'Randy Savage'

    factory :post_with_comment do
      comment
    end
  end
end
