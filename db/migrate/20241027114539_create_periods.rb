class CreatePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :periods do |t|
      t.references :lifetime, null: false, foreign_key: true
      t.datetime :start
      t.datetime :end
      t.text :title
      t.text :description
      t.text :color_hex

      t.timestamps
    end
  end
end
