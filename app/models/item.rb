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
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations
  
end