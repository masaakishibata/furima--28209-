require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@item).to be_valid
    end
    it 'imageが無いと保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'nameが空だと保存できないこと' do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it '商品の説明が空だと保存できない' do
      @item.description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'カテゴリーの情報が無いと保存できない' do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Category is not a number")
    end
    it 'カテゴリーのid:1は保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end
    it '商品の状態についての情報が無いと保存できない' do
      @item.status_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Status is not a number")
    end
    it '商品の状態についてのid:1は保存できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end
    it '配送料の負担についての情報が無いと保存できない' do
      @item.delivery_charge_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery charge is not a number")
    end
    it '配送料の負担についてのid:1は保存できない' do
      @item.delivery_charge_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
    end
    it '発送元の地域についての情報が無いと保存できない' do
      @item.shipment_source_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipment source is not a number")
    end
    it '発送元の地域についてのid:1は保存できない' do
      @item.shipment_source_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipment source must be other than 1")
    end
    it '発送までの日数についての情報が無いと保存できない' do
      @item.transport_days_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Transport days is not a number")
    end
    it '発送までの日数についてのid:1は保存できない' do
      @item.transport_days_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Transport days must be other than 1")
    end
    it '価格についての情報が無いと保存できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank", "Price Price can't be blank", "Price is not included in the list")
    end
    it '299以下の価格だと保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end
    it '10,000,000以上の価格だと保存できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end
    it '販売価格は半角数字でないと保存できない' do
      @item.price = "/\A[0-9]+\z/"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not included in the list")
    end
  end
end
