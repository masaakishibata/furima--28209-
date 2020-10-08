FactoryBot.define do
  factory :user do
    email { "shibata@test.com" }
    password {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    nickname { "chiwawa" }
    first_name { "柴田" }
    first_name_kana { "シバタ" }
    last_name { "正明" }
    last_name_kana { "マサアキ" }
    birthday { "1999-1-1" }
  end
end