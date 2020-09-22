class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save { self.email = email.downcase }

  validates :name, presence: true

  
  VALID_USER_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  validates :last_name, :first_name, presence: true, format: { with: VALID_USER_NAME_REGEX,
    message: "全角（漢字・ひらがな・カタカナ）を使し入力してください" }



  validates :password, confirmation: true
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[\d])\w{6}\z/
  validates :password, presence: true,
            format: { with: VALID_PASSWORD_REGEX,
             message: "は半角6文字・英小文字・数字それぞれ１文字以上含む必要があります"}
end
