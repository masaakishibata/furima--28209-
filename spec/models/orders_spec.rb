require 'rails_helper'

RSpec.describe Orders, type: :model do
  describe '#create' do
    before do
      seller = FactoryBot.create(:user)
      buyer = FactoryBot.create(:user, email: "test@text.com")
      item = FactoryBot.build(:item, user_id: seller.id)
      item.save
      @order = FactoryBot.build(:orders, item_id: item.id, user_id: buyer.id)
    end


    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order).to be_valid
    end
    it '郵便番号がないと保存できない' do
      @order.postal_code = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("郵便番号を入力してください", "郵便番号にはハイフンを含めてください。")
    end
    it '郵便番号が半角のハイフンを含んだ正しい形式でないと保存できない' do
      @order.postal_code = "/\A\d{3}[-]\d{4}\z/"
      @order.valid?
      expect(@order.errors.full_messages).to include("郵便番号にはハイフンを含めてください。")
    end
    it '都道府県を選択していないと保存できないこと' do
      @order.prefectures_id = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("都道府県を選択してください。")
    end
    it '都道府県はother_than:1では保存できないこと' do
      @order.prefectures_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("都道府県を選択してください。")
    end
    it '市区町村を入力しないと保存できない' do
      @order.municipality = ""
      @order.valid?
      expect(@order.errors.full_messages).to include("配送先の地域を入力してください")
    end
    it '住所・番地を入力しないと保存できない' do
      @order.house_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("住所・番地を入力してください")
    end
    it '建物名・部屋番号を入力しないと保存できない' do
      @order.building_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("建物名・部屋番号を入力してください")
    end
    it '電話番号を入力しないと保存できない' do
      @order.phone_number = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("電話番号を入力してください", "電話番号はハイフンを含まない11以内で入力をしてください。")
    end
    it '電話番号はハイフンは不要で、11桁以内でないと保存できない' do
      @order.phone_number = "/\A\d{11}\z/"
      @order.valid?
      expect(@order.errors.full_messages).to  include("電話番号はハイフンを含まない11以内で入力をしてください。")
    end
    it 'クレジットカード情報を入力しないと保存できない(token)' do
      @order.token = ""
      @order.valid?
      expect(@order.errors.full_messages).to  include("クレジットカード情報を入力してください")
    end
  end
end
