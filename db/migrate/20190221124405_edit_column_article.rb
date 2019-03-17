class EditColumnArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :pv, :integer, :default => 0
    change_column :articles, :text, :text
  end
end
