class ChangeForeignKeys < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :periods, :lifetimes
    add_foreign_key :periods, :lifetimes, on_delete: :cascade

    remove_foreign_key :lifetimes, :users
    add_foreign_key :lifetimes, :users, on_delete: :cascade
  end
end
