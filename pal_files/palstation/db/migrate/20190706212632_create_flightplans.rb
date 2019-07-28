class CreateFlightplans < ActiveRecord::Migration[5.2]
  def change
    create_table :flightplans do |t|
      t.datetime :updated_at
      t.integer :updated_by
      t.string :updated_by_me
      t.integer :waypoint_count
      t.integer :last_waypoint
      t.integer :step_waypoint

      t.timestamps
    end
  end
end
