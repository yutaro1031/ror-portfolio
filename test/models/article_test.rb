# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  title       :string(255)
#  user_id     :bigint(8)
#  eyecatch    :binary(65535)
#  text        :string(255)
#  publish_flg :boolean
#  del_flg     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
