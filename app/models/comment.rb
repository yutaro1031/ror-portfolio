# == Schema Information
#
# Table name: comments
#
#  id          :bigint(8)        not null, primary key
#  article_id  :bigint(8)
#  user_id     :bigint(8)
#  text        :string(255)      not null
#  publish_flg :boolean          default(TRUE), not null
#  del_flg     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
end
