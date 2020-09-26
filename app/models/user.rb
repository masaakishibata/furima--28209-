class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  name = / \ A [ぁ-んァ-ン一-龥] /
  katakana = / \ A [ァ-ヶー－] + \ z /
  password = / \ A [a-zA-Z] + \ z /
  year_month_day = /\A\d{4}-\d{2}-\d{2}\z/
  email = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates :email, uniqueness: true, format: { with: email }

  validates :last_name, presence: true, format: { with: name }

  validates :last_name_kana, presence: true, format: { with: katakana }

  validates :family_name, presence: true, format: { with: name }

  validates :family_name_kana, presence: true, format: { with: katakana }
  
  validates :password, presence: true, length: { minimum: 6 }, format: { with: password }

  validates :birthday, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/ }

end
