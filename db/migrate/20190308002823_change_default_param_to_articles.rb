class ChangeDefaultParamToArticles < ActiveRecord::Migration[5.2]
  def self.up
    change_column_default :articles, :publish_flg, false
  end

  def self.down
    change_column_default :articles, :publish_flg, true
  end
end
