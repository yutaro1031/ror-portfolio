# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  name                   :string(255)      not null
#  admin_flg              :boolean          default(FALSE), not null
#  del_flg                :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string(255)      not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

FactoryBot.define do
  factory :user do
    name { "test1" }
    password { "password" }
    password_confirmation { "password" }
    email { "test@gmail.com" }

    trait :admin_user do
      admin_flg { TRUE }
    end
  end
end
