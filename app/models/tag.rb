class Tag < ApplicationRecord
  has_many :item_tag_relations
  has_many :tweets, through: :item_tag_relations

  validates :tagname, uniqueness: true
end
