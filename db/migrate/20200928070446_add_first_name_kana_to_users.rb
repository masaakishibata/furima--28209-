class AddFirstNameKanaToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name_kana, :string
  end
end
