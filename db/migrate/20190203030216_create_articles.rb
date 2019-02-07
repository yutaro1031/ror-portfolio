class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.references :user, foreign_key: true
      t.binary :eyecatch
      t.string :text, null: false
      t.boolean :publish_flg, default: true, null: false
      t.boolean :del_flg, default: false, null: false

      t.timestamps
    end
  end
end
