class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :article, foreign_key: true
      t.references :user, foreign_key: true
      t.string :text, null: false
      t.boolean :publish_flg, default: true, null: false
      t.boolean :del_flg, default: false, null: false

      t.timestamps
    end
  end
end
