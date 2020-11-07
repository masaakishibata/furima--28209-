class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  with_options presence: true do
    validates :birthday
    validates :nickname
    validates :email, uniqueness: true
    
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください。' } do
      validates :first_name
      validates :last_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角（カタカナ）で入力してください。' } do
      validates :first_name_kana
      validates :last_name_kana
    end

    with_options format: { with: /\A[a-zA-Z0-9]+\z/, message: 'を確認のため再入力入力してください。' } do
      validates :password, length: {minimum: 6} 
    end
  end
  
  has_many :items
  has_many :sns_credentials
  has_one :user_item

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end