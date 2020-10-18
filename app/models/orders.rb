class Orders
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :prefectures_id, :municipality, :house_number, :building_number, :postal_code, :phone_number

  with_options presence: true do
    validates :municipality
    validates :building_number
    validates :postal_code
    validates :phone_number
    validates :house_number
    validates :token
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

  def save

    order = UserItem.create(
    user_id: user_id, 
    item_id: item_id)

    OrdersInformation.create(
    municipality: municipality,
    building_number: building_number,
    house_number: house_number,
    postal_code: postal_code,
    phone_number: phone_number,
    prefectures_id: prefectures_id,
    user_item_id: order.id)
     

  end
end