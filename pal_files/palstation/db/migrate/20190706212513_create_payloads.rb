class CreatePayloads < ActiveRecord::Migration[5.2]
  def change
    create_table :payloads do |t|
      t.datetime :created_at
      t.boolean :is_sent
      t.boolean :is_received
      t.references :pal, foreign_key: true

      t.timestamps
    end
  end
end
