class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :address_line, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

    validates :prefecture_id, numericality: { other_than: 1 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(postcode: postcode, prefecture_id: prefecture_id, city: city, address_line: address_line, building: building, phone_number: phone_number, order_id: order_id)
  end
end