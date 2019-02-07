# == Schema Information
#
# Table name: tag_relations
#
#  id         :bigint(8)        not null, primary key
#  article_id :bigint(8)
#  tag_id     :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TagRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
