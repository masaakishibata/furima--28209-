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
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it 'ユーザー本名が、名字と名前がそれぞれ必須であること' do
      @user.first_name = ""
      @user.family_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name is invalid. Input full-width characters.")
    end
    it 'ユーザー本名は全角（漢字・ひらがな・カタカナ）で入力しないと保存できない' do
      @user.last_name = "/ \ A [ぁ-んァ-ン一-龥] /"
      @user.family_name = "/ \ A [ぁ-んァ-ン一-龥] /"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name is invalid. Input full-width / \ A [ぁ-んァ-ン一-龥] / characters.")
    end
    it 'first_name_kana_readingが空だと保存できないこと' do
      @user.first_name_kana_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name reading can't be blank")
    end
    it 'family_name_kana_readingが空だと保存できないこと' do
      @user.family_name_kana_reading = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Name reading can't be blank")
    end
    it 'first_name_kana_readingが全角（カタカナ）でないと保存できないこと' do
      @user.first_name_kana_reading = " / \ A [ァ-ヶー－] + \ z /"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
    end
    it 'family_name_kana_readingが全角（カタカナ）でないと保存できないこと' do
      @user.last_name_kana_reading = " / \ A [ァ-ヶー－] + \ z /"
      @user.valid?
      expect(@user.errors.full_messages).to include("Name reading is invalid. Input full-width katakana characters.")
    end
    it '生年月日が必須で入力がないと保存できない' do
      @user.birthday = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday reading is invalid. Input full-width /\A\d{4}-\d{2}-\d{2}\z/ characters.")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "重複したemailが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.vaild?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it 'メールアドレスは@を含む必要があること' do
      @user.email = "/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i"
      @user.valid?
      expect(@user_donation.errors.full_messages).to include("Email reading is invalid. Input full-width /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i characters.")
    end
    it 'パスワードが必須であること' do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "passwordが6文字でなければ登録できない" do
      @user.password = "000000"
      @user.password_confirmation = "000000"
      @user.vaild?
      expect(@user.errors.full_messages).to include("password is too short (minimum is 6 characters)")
    end
    it "passwordが存在してもpassword_confirmationが空では登録ができない" do
      @user.password_confirmation = ""
      @user.vaild?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードは半角英数字混合であること' do
      @user.password = " / \ A [a-zA-Z] + \ z /"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password reading is invalid. Input full-width / \ A [a-zA-Z] + \ z / characters.")
    end
    it 'エラーが表示されること' do
      post user_registration_path, params: { user: invalid_user_params }
      expect(response.body).to include('prohibited this user from being saved')
    end
  end
end