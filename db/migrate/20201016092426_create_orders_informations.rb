class CreateOrdersInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_informations do |t|
      t.string     :municipality,           null: false
      t.string     :building_number,        null: false
      t.string     :house_number,           null: false
      t.string     :postal_code,            null: false
      t.string     :phone_number,           null: false
      t.integer    :prefectures_id,         null: false
      t.references :user_item,             foreign_key: true
      t.timestamps
    end
  end
end
