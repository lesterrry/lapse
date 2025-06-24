class RenameSavedLifetimesToSavings < ActiveRecord::Migration[7.0]
  def change
    rename_table :saved_lifetimes, :savings
  end
end