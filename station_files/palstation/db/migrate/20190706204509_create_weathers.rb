class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.references :station, foreign_key: true
      t.float :score
      t.text :description
      t.datetime :updated_at

      t.timestamps
    end
  end
end
