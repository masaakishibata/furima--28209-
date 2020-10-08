class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :birthday
    validates :nickname
    validates :email, uniqueness: true

    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'Full-width characters' } do
      validates :first_name
      validates :last_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width characters' } do
      validates :first_name_kana
      validates :last_name_kana
    end

    with_options format: { with: /\A[a-zA-Z0-9]+\z/, message: 'Password reading is invalid. Input full-width characters' } do
      validates :password, length: {minimum: 6} 
    end
  end
end