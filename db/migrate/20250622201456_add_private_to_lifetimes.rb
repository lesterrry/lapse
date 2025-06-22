class AddPrivateToLifetimes < ActiveRecord::Migration[7.0]
  def change
    add_column :lifetimes, :private, :boolean, default: false, null: false
  end
end
