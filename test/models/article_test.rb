# == Schema Information
#
# Table name: articles
#
#  id           :bigint(8)        not null, primary key
#  title        :string(255)      not null
#  user_id      :bigint(8)
#  eyecatch     :string(255)
#  text         :text(65535)      not null
#  publish_flg  :boolean          default(FALSE), not null
#  del_flg      :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  pv           :integer          default(0)
#  tmp_title    :string(255)
#  tmp_eyecatch :string(255)
#  tmp_text     :text(65535)
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
