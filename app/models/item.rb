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

  with_options format: { with: /\A[0-9]+\z/, message: "Price can't be blank" } do
    validates :price
    validates_inclusion_of :price, in: 300..999999
  end

  with_options numericality: { other_than: 1 } do
    validates :status_id
    validates :category_id
    validates :delivery_charge_id
    validates :shipment_source_id
    validates :transport_days_id
  end
  
end