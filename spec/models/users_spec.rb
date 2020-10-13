require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@user).to be_valid
    end
    it 'nicknameが空だと保存できないこと' do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'ユーザー本名が、名前が必須であること' do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name Full-width characters")
    end
    it 'ユーザー本名が、名字が必須であること' do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
    end
    it 'ユーザーの名前は全角（漢字・ひらがな・カタカナ）で入力しないと保存できない' do
      @user.last_name = "/\A[ぁ-んァ-ン一-龥]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name Full-width characters")
    end
    it 'ユーザー苗字は全角（漢字・ひらがな・カタカナ）で入力しないと保存できない' do
      @user.first_name = "/\A[ぁ-んァ-ン一-龥]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters")
    end
    it 'first_name_kana_readingが空だと保存できないこと' do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana Full-width characters")
    end
    it 'last_name_kana_readingが空だと保存できないこと' do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana Full-width characters")
    end
    it 'first_name_kana_readingが全角（カタカナ）でないと保存できないこと' do
      @user.first_name_kana = "/\A[ァ-ヶー－]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana Full-width characters")
    end
    it 'last_name_kana_readingが全角（カタカナ）でないと保存できないこと' do
      @user.last_name_kana = "/\A[ァ-ヶー－]+\Z/"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana Full-width characters")
    end
    it '生年月日が必須で入力がないと保存できない' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    it 'メールアドレスは@を含む必要があること' do
      @user.email = "test.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end
    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "passwordが6文字以上でなければ登録できない" do
      @user.password_confirmation = "00000"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "passwordが存在してもpassword_confirmationが空では登録ができない" do
      @user.password_confirmation = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは半角数字のみでは登録できない' do
      @user.password = "111111"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは半角英字のみでは登録できない' do
      @user.password = "aaaaaa"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end