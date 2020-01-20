class AddCommentsCountToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :comments_count, :integer, default: 0
  end
end
