class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :status
  belongs_to_active_hash :category
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :shipment_source
  belongs_to_active_hash :transport_days

  belong_to :user
  has_one_attached :image

  with_options presence: true do
    with_options format: { with: :title, :text }
      validates :status_id, numericality: { other_than: 1 }
      validates :category_id, numericality: { other_than: 1 }
      validates :delivery_charge_id, numericality: { other_than: 1 }
      validates :shipment_source_id, numericality: { other_than: 1 }
      validates :transport_days_id, numericality: { other_than: 1 }
    end
  end
end
