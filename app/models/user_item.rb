class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :orders_information
end
