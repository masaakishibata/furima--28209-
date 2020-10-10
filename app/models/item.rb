class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :shipment_source
  belongs_to_active_hash :transport_days

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
    validates :price
  end
  validates :price, numericality: { minimum: 300} 
  validates :price, numericality: { maximum: 9_999_999 } 

  with_options numericality: { other_than: 1 } do
    validates :status_id
    validates :category_id
    validates :delivery_charge_id
    validates :shipment_source_id
    validates :transport_days_id
  end
  
end