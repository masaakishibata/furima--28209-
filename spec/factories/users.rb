FactoryBot.define do
  factory :users do
    name { '鈴木' }
    name_reading { 'スズキ' }
    nickname { 'suzuki' }
    postal_code { '123-4567' }
    prefecture { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    price { 2000 }
  end
end
