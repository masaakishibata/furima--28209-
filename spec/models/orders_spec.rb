require 'rails_helper'

RSpec.describe Orders, type: :model do
  describe '#create' do
    before do
      seller = FactoryBot.create(:user)
      buyer = FactoryBot.create(:user, email: "test@text.com")
      item = FactoryBot.build(:item, user_id: seller.id)
      item.save
      @order = FactoryBot.build(:orders, item_id: item.id, user_id: buyer.id)
      sleep(3)
    end


    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order).to be_valid
    end
    it 'postal_codeが空だと保存できないこと' do
      @order.postal_code = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order.postal_code = "/\A\d{3}[-]\d{4}\z/"
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code Postal_code can't be blank")
    end
    it 'prefectureを選択していないと保存できないこと' do
      @order.prefectures_id = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Postal code Postal_code can't be blank", "Prefectures is not a number")
    end
    it 'municipalityは空では保存できない' do
      @order.municipality = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("Municipality can't be blank")
    end
    it 'house_numberは空では保存できない' do
      @order.house_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("House number can't be blank", "Postal code Postal_code can't be blank")
    end
    it 'building_numberは空では保存できない' do
      @order.building_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("Building number can't be blank", "Postal code Postal_code can't be blank")
    end
    it 'phone_numberは空では保存できない' do
      @order.phone_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("Phone number can't be blank", "Phone number Phone_number can't be blank", "Postal code Postal_code can't be blank")
    end
    it 'phone_numberはハイフンは不要で、11桁以内でないと保存できない' do
      @order.phone_number = "/\A\d{11}\z/"
      @order.valid?
      expect(@order.errors.full_messages).to  include("Postal code Postal_code can't be blank", "Phone number Phone_number can't be blank")
    end
    it 'tokenは空では保存できない' do
      @order.token = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("Token can't be blank")
    end
  end
end
