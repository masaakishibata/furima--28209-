class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name, presence: true
  validates :last_name_kana, presence: true
  validates :biryhday, presence: true
  validates :nickname, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true, length: {minimum: 6}
end