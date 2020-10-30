require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user).to be_valid
    end
    it 'ニックネームを入力しないと保存できない' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end
    it '名前の入力が必須である' do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角（漢字・ひらがな・カタカナ）で入力してください。")
    end
    it '苗字の入力が必須である' do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください", "苗字は全角（漢字・ひらがな・カタカナ）で入力してください。")
    end
    it '名前は全角（漢字・ひらがな・カタカナ）で入力しないと保存できない' do
      @user.last_name = "/\A[ぁ-んァ-ン一-龥]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前は全角（漢字・ひらがな・カタカナ）で入力してください。")
    end
    it '苗字は全角（漢字・ひらがな・カタカナ）で入力しないと保存できない' do
      @user.first_name = "/\A[ぁ-んァ-ン一-龥]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字は全角（漢字・ひらがな・カタカナ）で入力してください。")
    end
    it '苗字(カタカナ)の入力がないと保存できない' do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字(カタカナ)を入力してください", "苗字(カタカナ)は全角（カタカナ）で入力してください。")
    end
    it '名前(カタカナ)の入力がないと保存できない' do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("名前(カタカナ)を入力してください", "名前(カタカナ)は全角（カタカナ）で入力してください。")
    end
    it '苗字(カタカナ)が全角（カタカナ）でないと保存できないこと' do
      @user.first_name_kana = "/\A[ァ-ヶー－]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字(カタカナ)は全角（カタカナ）で入力してください。")
    end
    it '名前(カタカナ)が全角（カタカナ）でないと保存できないこと' do
      @user.last_name_kana = "/\A[ァ-ヶー－]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("名前(カタカナ)は全角（カタカナ）で入力してください。")
    end
    it '誕生日の入力がないと保存できない' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("誕生日を入力してください")
    end
    it 'メールアドレスは@を含む必要がある' do
      @user.email = "test.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールは不正な値です")
    end
    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
    end
    it "パスワードが6文字以上でなければ登録できない" do
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it "パスワードが存在してもpassword_confirmationが空では登録ができない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'パスワードは半角数字のみでは登録できない' do
      @user.password = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
    it 'パスワードは半角英字のみでは登録できない' do
      @user.password = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end
  end
end