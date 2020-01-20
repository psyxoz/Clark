class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to(:user)
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end

    add_foreign_key :articles, :users, on_delete: :cascade
  end
end
