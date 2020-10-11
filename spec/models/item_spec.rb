require 'rails_helper'

RSpec.describe Item, type: :model do
  let (:item) { FactoryBot.create(:item) }
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
      expect(@item.errors.full_messages).to include()
    end
    it 'nameが空だと保存できないこと' do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("name can't be blank")
    end
    it '商品の説明が空だと保存できない' do
      @item.description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it 'カテゴリーの情報が無いと保存できない' do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '商品の状態についての情報が無いと保存できない' do
      @item.status_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '配送料の負担についての情報が無いと保存できない' do
      @item.delivery_charge_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '発送元の地域についての情報が無いと保存できない' do
      @item.shipment_source_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '発送までの日数についての情報が無いと保存できない' do
      @item.transport_days_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '発送までの日数についての情報が無いと保存できない' do
      @item.transport_days_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '価格についての情報が無いと保存できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '価格についての情報が無いと保存できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
    it '販売価格は半角数字でないと保存できない' do
      @item.price = "/\A[0-9]+\z/"
      @item.valid?
      expect(@item.errors.full_messages).to include()
    end
  end
end
