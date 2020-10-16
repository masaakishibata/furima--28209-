class OrdersInformation < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user_item

  with_options presence: true do
    validates :municipality
    validates :building_number
    validates :postal_code
    validates :phone_number
  end

  with_options format: { with: /\A\d{3}[-]\d{4}\z/, message: "Postal_code can't be blank" } do
    validates :postal_code
  end

  with_options format: { with: /\A\d{11}\z/, message: "Phone_number can't be blank" } do
    validates :phone_number
  end

  with_options numericality: { other_than: 1 } do
    validates :prefectures_id
  end

end
