class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, :password, null: false
      t.string :role, null: false, default: :default
      t.timestamps
    end
  end
end
