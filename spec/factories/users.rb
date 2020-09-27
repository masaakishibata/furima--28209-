FactoryBot.define do
  factory :user do
    first_name {Faker::Name}
    family_name {Faker::Name}
    email {Faker::Internet.email}
    password {Faker::password(min_length: 6)}
    password_confirmation {password}
    birthday {Faker::Internet.Birthday}
  end
end