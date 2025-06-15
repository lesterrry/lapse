class AddViewCountToLifetimes < ActiveRecord::Migration[7.0]
  def change
    add_column :lifetimes, :view_count, :integer, default: 0
  end
end
