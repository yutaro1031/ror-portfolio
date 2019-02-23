class AddColumnArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :tmp_title, :string
    add_column :articles, :tmp_eyecatch, :string
    add_column :articles, :tmp_text, :text
    change_column :articles, :eyecatch, :string
  end
end
