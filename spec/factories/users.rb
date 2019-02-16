FactoryBot.define do
  factory :user do
    name { "test1" }
    password { "password" }
    password_confirmation { "password" }

    trait :admin_user do
      admin_flg { TRUE }
    end
  end
end