json.extract! flightplan, :id, :updated_at, :updated_by, :updated_by_me, :waypoint_count, :last_waypoint, :step_waypoint, :created_at, :updated_at
json.url flightplan_url(flightplan, format: :json)
