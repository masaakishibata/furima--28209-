class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :shipment_source
  belongs_to_active_hash :transport_days

  belongs_to :user
  has_one :user_item
  has_many_attached :images

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :images
  end

  validates :price,
    numericality: {
    greater_than_or_equal_to: 300,
    less_than: 9999999,
    message: "は300円〜9,999,999円の間で入力してください。" 
    }

  with_options format: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください。" } do
    validates :price
  end

  with_options numericality: { other_than: 1, message: "を選択してください。" } do
    validates :status_id
    validates :category_id
    validates :delivery_charge_id
    validates :shipment_source_id
    validates :transport_days_id
  end
  
end