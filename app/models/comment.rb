# == Schema Information
#
# Table name: comments
#
#  id          :bigint(8)        not null, primary key
#  article_id  :bigint(8)
#  user_id     :bigint(8)
#  text        :string(255)
#  publish_flg :boolean
#  del_flg     :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
end
