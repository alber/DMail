json.extract! station, :id, :name, :admin, :location, :lat, :long, :parent_id, :status, :service_away_id, :service_home_id, :total, :is_docked, :docked_id, :tier, :current_weatherscore, :is_me, :created_at, :updated_at
json.url station_url(station, format: :json)
