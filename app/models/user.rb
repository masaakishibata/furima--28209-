class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  name = /\A[ぁ-んァ-ン一-龥] \ Z /
  katakana = /\ A [ァ-ヶー－] + \ Z /
  password = /\ A [a-z0-9] + \ z /
  year_month_day = /\A\d{4}-\d{2}-\d{2}\z/
  email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :email, uniqueness: true, format: { with: email }

  validates :first_name, presence: true, format: { with: name }

  validates :first_name_kana, presence: true, format: { with: katakana }

  validates :family_name, presence: true, format: { with: name }

  validates :family_name_kana, presence: true, format: { with: katakana }
  
  validates :password, presence: true, length: { minimum: 6 }, format: { with: password }

  validates :birthday, presence: true, format: { with: year_month_day }

end
