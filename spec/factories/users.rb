FactoryBot.define do
  factory :user do
    first_name  = Faker::Name.first_name
    family_name  = Faker::Name.family_name
    first_name_kana = Faker::Name.first_name_kana
    family_name_kana = Faker::Name.family_name_kana
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 6)
    password_confirmation {password}
    birthday = Faker::Date.birthday(min_age：18, max_age：65)
  end
end