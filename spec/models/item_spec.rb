require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@item).to be_valid
    end
    it '画像が無いと保存できない' do
      @item.images = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("画像を入力してください")
    end
    it '商品名の入力がないと保存できないこと' do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end
    it '商品の説明が空だと保存できない' do
      @item.description = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品説明を入力してください")
    end
    it 'カテゴリーの情報が無いと保存できない' do
      @item.category_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品のカテゴリ-を選択してください。")
    end
    it 'カテゴリーのid:1は保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("商品のカテゴリ-を選択してください。")
    end
    it '商品の状態についての情報が無いと保存できない' do
      @item.status_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を選択してください。")
    end
    it '商品の状態についてのid:1は保存できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を選択してください。")
    end
    it '配送料の負担についての情報が無いと保存できない' do
      @item.delivery_charge_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("送料の負担を選択してください。")
    end
    it '配送料の負担についてのid:1は保存できない' do
      @item.delivery_charge_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("送料の負担を選択してください。")
    end
    it '発送元の地域についての情報が無いと保存できない' do
      @item.shipment_source_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("配送元を選択してください。")
    end
    it '発送元の地域についてのid:1は保存できない' do
      @item.shipment_source_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("配送元を選択してください。")
    end
    it '発送までの日数についての情報が無いと保存できない' do
      @item.transport_days_id = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の配送期間を選択してください。")
    end
    it '発送までの日数についてのid:1は保存できない' do
      @item.transport_days_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の配送期間を選択してください。")
    end
    it '価格についての情報が無いと保存できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を入力してください", "価格は300円〜9,999,999円の間で入力してください。", "価格は半角数字で入力してください。")
    end
    it '299以下の価格だと保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円〜9,999,999円の間で入力してください。")
    end
    it '10,000,000以上の価格だと保存できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円〜9,999,999円の間で入力してください。")
    end
    it '販売価格は半角数字でないと保存できない' do
      @item.price = "/\A[0-9]+\z/"
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円〜9,999,999円の間で入力してください。")
    end
  end
end
