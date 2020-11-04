class ItemTags
  include ActiveModel::Model
  attr_accessor :name,
                :description,
                :price,
                :images,
                :status_id,
                :category_id,
                :delivery_charge_id,
                :shipment_source_id,
                :transport_days_id,
                :tagname,
                :item_id,
                :tag_id,
                :user_id

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

  def save

    item = Item.create(
      name: name,
      description: description,
      price: price,
      images: images,
      status_id: status_id,
      category_id: category_id,
      delivery_charge_id: delivery_charge_id,
      shipment_source_id: shipment_source_id,
      transport_days_id: transport_days_id,
      user_id: user_id)

      tag = Tag.where(tagname: tagname).first_or_initialize
      tag.save

    ItemTagRelation.create(
      item_id: item.id,
      tag_id: tag.id)
  end

  def update(params, item)
  
    tag_name = params.delete(:tagname)
    tag_id = params.delete(:tag_id)
    
    item.update(params)

      tag = Tag.where(tagname: tagname).first_or_initialize
      tag.save

    ItemTagRelation.update(
      item_id: item_id,
      tag_id: tag_id)
    

  end


  # def self.saerch(saerch)
  #   return Post.all unless saerch
  #   Post.where(['content LIKE ?', "%#{saerch}%"])
  # end

end