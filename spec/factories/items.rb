FactoryBot.define do
  factory :item do
    name {Faker::Name.name}
    description { "最高の商品です。"}
    price {Faker::Date.price.between(min_numericality: 300, max_numericality: 9_999_999)}
    status_id {id:2}
    category_id {id:3}
    delivery_charge_id {id:4}
    shipment_source_id {id:5}
    transport_days_id {id:5}
    association :user, factory: :tom
  end
end
