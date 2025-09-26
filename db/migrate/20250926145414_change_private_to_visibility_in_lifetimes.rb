class ChangePrivateToVisibilityInLifetimes < ActiveRecord::Migration[7.0]
  def up
    # Add the new visibility column as integer (for enum)
    add_column :lifetimes, :visibility, :integer, default: 0, null: false

    # Migrate existing data
    execute <<-SQL
      UPDATE lifetimes
      SET visibility = CASE
        WHEN private = true THEN 1
        ELSE 0
      END
    SQL

    # Remove the old private column
    remove_column :lifetimes, :private
  end

  def down
    # Add back the private column
    add_column :lifetimes, :private, :boolean, default: false, null: false

    # Migrate data back
    execute <<-SQL
      UPDATE lifetimes
      SET private = CASE
        WHEN visibility = 1 THEN true
        ELSE false
      END
    SQL

    # Remove the visibility column
    remove_column :lifetimes, :visibility
  end
end
