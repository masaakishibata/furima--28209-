class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :name,                   null: false
      t.text       :description,            null: false
      t.integer    :price,                  null: false
      t.integer    :status_id,              null: false
      t.integer    :category_id,            null: false
      t.integer    :delivery_charge_id,     null: false
      t.integer    :shipment_source_id,     null: false
      t.integer    :transport_days_id,      null: false
      t.references :user,                   foreign_key: true
      t.timestamps
    end
  end
end