json.extract! waypoint, :id, :lat, :long, :step, :flightplan_id, :created_at, :updated_at
json.url waypoint_url(waypoint, format: :json)
