json.extract! payload, :id, :created_at, :is_sent, :is_received, :pal_id, :created_at, :updated_at
json.url payload_url(payload, format: :json)
