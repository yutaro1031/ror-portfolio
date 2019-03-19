# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development'
  Tag.create([
                 { name: 'Ruby on Rails4' },
                 { name: 'Ruby on Rails5' },
                 { name: 'Python2' },
                 { name: 'Python3' },
                 { name: 'Django2' },
             ])
  # (1..50).each do |i|
  #   Article.create(title: "タイトル#{i}", user_id: 2, text: "本文#{i}")
  # end
  #
  # (1..50).each do |i|
  #   TagRelation.create(article_id: i, tag_id: 3)
  #   TagRelation.create(article_id: i, tag_id: 4)
  # end
  # article = Article.find_by(id: 1)
  # article.update(del_flg: TRUE)

  # user = User.find_by(id: 5)
  # user.update(admin_flg: TRUE)
  # User.delete_all
  user = User.create(name: "admin", email: "admin@gmail.com", password: "password", password_confirmation: "password", admin_flg: TRUE)
  user.confirm
  user = User.create(name: "normal", email: "normal@gmail.com", password: "password", password_confirmation: "password", admin_flg: FALSE)
  user.confirm

=begin
【メモ】
Article.delete_all
を行ったらできずにハマった。
原因はdelete_allメソッドが関連づけられているレコードを考慮せずに実行するから。
destroy_allであれば、ActiveRecordを介することで関連づけれらた他テーブルのレコードも同時に削除してくれる。

=end

  # Article.destroy_all

  (1..50).each do |i|
    Article.create(title: "タイトル#{i}",
                   user_id: 1,
                   text: "本文#{i}",
                   publish_flg: true,
                   eyecatch: open("#{Rails.root}/db/fixtures/no-image.png")
                   )
  end
  #
  # (1..50).each do |i|
  #     TagRelation.create(article_id: i, tag_id: 3)
  #     TagRelation.create(article_id: i, tag_id: 4)
  #   end

  # (1..10).each do |i|
  #     Comment.create(user_id:1, article_id:53, text: "コメント#{i}")
  # end

end

if Rails.env == 'production'
  Tag.create([
                 { name: 'Ruby on Rails4' },
                 { name: 'Ruby on Rails5' },
                 { name: 'Python2' },
                 { name: 'Python3' },
                 { name: 'Django2' }
             ])

  user = User.create(name: "admin", email: "admin@gmail.com", password: "password", password_confirmation: "password", admin_flg: TRUE)
  user.confirm
  user = User.create(name: "normal", email: "normal@gmail.com", password: "password", password_confirmation: "password", admin_flg: FALSE)
  user.confirm

  (1..50).each do |i|
    Article.create(title: "タイトル#{i}",
                   user_id: 2,
                   text: "本文#{i}",
                   publish_flg: true,
                   eyecatch: open("#{Rails.root}/db/fixtures/no-image.png")
    )
  end
end