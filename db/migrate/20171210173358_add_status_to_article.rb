class AddStatusToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :status, :integer, default: 0
    add_index :articles, :status
  end
end
