class CreateWaypoints < ActiveRecord::Migration[5.2]
  def change
    create_table :waypoints do |t|
      t.float :lat
      t.float :long
      t.integer :step
      t.references :flightplan, foreign_key: true

      t.timestamps
    end
  end
end
