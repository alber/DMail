class AddWeatherScoreToFlightplans < ActiveRecord::Migration[5.2]
  def change
    add_column :flightplans, :weather_score, :float
    add_column :flightplans, :weather_pass, :boolean
  end
end
