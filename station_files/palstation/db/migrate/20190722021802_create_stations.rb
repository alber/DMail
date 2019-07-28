class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :name
      t.string :admin
      t.string :location
      t.float :lat
      t.float :long
      t.integer :parent_id
      t.string :status
      t.integer :unconfirmed
      t.integer :confirmed
      t.integer :total
      t.boolean :is_docked
      t.integer :docked_id
      t.integer :tier
      t.integer :current_weatherscore
      t.boolean :is_me

      t.timestamps
    end
  end
end
