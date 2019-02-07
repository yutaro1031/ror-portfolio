# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  admin_flg       :boolean          default(FALSE), not null
#  del_flg         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password

  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: 16 },
            format: {
                with: /\A[a-z0-9]+\z/,
                message: 'は小文字英数字で入力してください'
            }

  validates :password_digest,
            length: { minimum: 8 }

  has_many :articles
end
