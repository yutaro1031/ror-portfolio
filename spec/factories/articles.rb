# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)      not null
#  user_id     :bigint(8)
#  eyecatch    :binary(65535)
#  text        :string(255)      not null
#  publish_flg :boolean          default(TRUE), not null
#  del_flg     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :article do
    title { "test_article" }
    text { "test" }

  end
end
