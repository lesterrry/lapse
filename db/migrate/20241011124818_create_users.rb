class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name

      t.string :email, null: false, default: ''

      t.datetime :remember_created_at
      t.string :remember_token

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
