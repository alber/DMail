class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :author
      t.datetime :authored
      t.integer :authored_at
      t.string :format
      t.text :body
      t.binary :data
      t.integer :received_at
      t.integer :received_by
      t.string :received_by_me
      t.boolean :is_received
      t.boolean :is_sent
      t.integer :jump
      t.integer :destination_id
      t.integer :final_destination_id
      t.text :manifest

      t.timestamps
    end
  end
end
