# == Schema Information
#
# Table name: articles
#
#  id           :bigint(8)        not null, primary key
#  title        :string(255)      not null
#  user_id      :bigint(8)        (not null)
#  eyecatch     :string(255)
#  text         :text(65535)      not null
#  publish_flg  :boolean          default(TRUE), not null
#  del_flg      :boolean          default(FALSE), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  pv           :integer          default(0)
#  tmp_title    :string(255)
#  tmp_eyecatch :string(255)
#  tmp_text     :text(65535)
#

class Article < ApplicationRecord
  mount_uploader :eyecatch, PictureUploader
  mount_uploader :tmp_eyecatch, PictureUploader

  belongs_to :user

  has_many :comments, dependent: :delete_all
  has_many :tag_relations, dependent: :delete_all
  has_many :tags, through: :tag_relations
end
