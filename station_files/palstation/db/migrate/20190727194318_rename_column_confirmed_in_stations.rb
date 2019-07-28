class RenameColumnConfirmedInStations < ActiveRecord::Migration[5.2]
  def change
    rename_column :stations, :confirmed, :service_home_id
    rename_column :stations, :unconfirmed, :service_away_id
  end
end
