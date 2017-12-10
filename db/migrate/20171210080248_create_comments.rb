class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :article
      t.text :content, null: false
      t.timestamps
    end

    add_foreign_key :comments, :users, on_delete: :cascade
    add_foreign_key :comments, :articles, on_delete: :cascade
  end
end
