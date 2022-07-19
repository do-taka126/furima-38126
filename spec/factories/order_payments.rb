FactoryBot.define do
  factory :order_payment do
    token         { 'tok_aabbccddeeff0000000000000000' }
    postcode      { '123-4567' }
    prefecture_id { 13 }
    city          { '横浜市緑区' }
    address_line  { '青山1-1-1' }
    building      { '柳ビル101' }
    phone_number  { '09012345678' }    
  end
end
