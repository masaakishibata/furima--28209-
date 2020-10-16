class UserItem < ApplicationRecord
  belong_to :item
  belong_to :user
  has_one :orders_information
end
