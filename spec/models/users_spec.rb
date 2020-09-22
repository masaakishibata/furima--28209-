require 'rails_helper'

RSpec.describe UserDonation, type: :model do
  describe '寄付情報の保存' do
    before do
      @user_donation = FactoryBot.build(:user_donation)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user_donation).to be_valid
    end
    it 'nameが空だと保存できないこと' do
      @user_donation.name = nil
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Name can't be blank")
    end
    it 'nameが全角日本語でないと保存できないこと' do
      @user_donation.name = "suzuki"
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Name is invalid. Input full-width characters.")
    end
    it 'name_readingが空だと保存できないこと' do
      @user_donation.name_reading = nil
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Name reading can't be blank")
    end
    it 'name_readingが全角日本語でないと保存できないこと' do
      @user_donation.name_reading = "ｽｽﾞｷ"
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
    end
    it 'nicknameが空だと保存できないこと' do
      @user_donation.nickname = nil
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'nicknameが半角でないと保存できないこと' do
      @user_donation.nickname = "すずき"
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Nickname is invalid. Input half-width characters.")
    end
    it 'postal_codeが空だと保存できないこと' do
      @user_donation.postal_code = nil
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @user_donation.postal_code = '1234567'
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @user_donation.prefecture = 0
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'cityは空でも保存できること' do
      @user_donation.city = nil
      expect(@user_donation).to be_valid
    end
    it 'house_numberは空でも保存できること' do
      @user_donation.house_number = nil
      expect(@user_donation).to be_valid
    end
    it 'building_nameは空でも保存できること' do
      @user_donation.building_name = nil
      expect(@user_donation).to be_valid
    end
    it 'priceが空だと保存できないこと' do
      @user_donation.price = nil
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが全角数字だと保存できないこと' do
      @user_donation.price = '２０００'
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Price is invalid. Input half-width characters.")
    end
    it 'priceが1円未満では保存できないこと' do
      @user_donation.price = 0
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Price is out of setting range")
    end
    it 'priceが1,000,000円を超過すると保存できないこと' do
      @user_donation.price = 1000001
      @user_donation.valid?
      expect(@user_donation.errors.full_messages).to include("Price is out of setting range")
    end
  end
end