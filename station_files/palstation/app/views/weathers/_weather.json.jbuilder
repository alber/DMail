json.extract! weather, :id, :station_id, :score, :description, :updated_at, :created_at, :updated_at
json.url weather_url(weather, format: :json)
