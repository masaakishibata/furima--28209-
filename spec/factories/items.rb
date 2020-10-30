FactoryBot.define do
  factory :item do
    name {Faker::Name.name}
    description { "最高の商品です。"}
    price {1000}
    status_id {2}
    category_id {3}
    delivery_charge_id {4}
    shipment_source_id {5}
    transport_days_id {5}
    association :user

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
