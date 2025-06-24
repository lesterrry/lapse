class CreateSavedLifetimes < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_lifetimes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lifetime, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :saved_lifetimes, [:user_id, :lifetime_id], unique: true
  end
end