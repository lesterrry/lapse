class AddStartFinishPointsToLifetime < ActiveRecord::Migration[7.0]
  def change
    add_column :lifetimes, :start_point, :string, null: true
    add_column :lifetimes, :finish_point, :string, null: true
  end
end
