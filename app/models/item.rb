class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :item_status
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_date
  has_one_attached :image
  belongs_to :user

  with_options presence: true do
    validates :name, :detail, :image

    with_options numericality: { other_than: 1 } do
      validates :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id
    end

    with_options format: { with: /\A[0-9]+\z/ } do
      validates :price, numericality: { greater_than: 300, less_than: 9999999 }
    end
  end
end
