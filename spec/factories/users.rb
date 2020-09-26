FactoryBot.define do
  factory :user do
    name {Faker::Name.last_name.last_name_kana.family_name.family_name_kana}
    email {Faker::Internet.free_email}
    password = Faker::Internet.password(min_length: 6)
    password {password}
    password_confirmation {password}
    birthday {Faker::Internet.year.month.day}
  end
end