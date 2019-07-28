class CreatePals < ActiveRecord::Migration[5.2]
  def change
    create_table :pals do |t|
      t.string :status
      t.string :location
      t.float :lat
      t.float :long
      t.references :payload, foreign_key: true
      t.references :flightplan, foreign_key: true

      t.timestamps
    end
  end
end
