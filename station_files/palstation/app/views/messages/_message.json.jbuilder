json.extract! message, :id, :author, :authored, :authored_at, :format, :body, :data, :received_at, :received_by, :received_by_me, :is_received, :is_sent, :jump, :destination_id, :final_destination_id, :manifest, :created_at, :updated_at
json.url message_url(message, format: :json)
