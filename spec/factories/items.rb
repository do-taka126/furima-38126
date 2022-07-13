FactoryBot.define do
  factory :item do
    name              { Faker::Name.initials }
    detail            { Faker::Lorem.sentence }
    category_id       { 2 } 
    item_status_id    { 2 }
    shipping_cost_id  { 2 }
    prefecture_id     { 2 }
    shipping_date_id  { 2 }
    price             { 500 }

    association :user
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
