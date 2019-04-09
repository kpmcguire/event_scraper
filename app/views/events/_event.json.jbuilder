json.extract! event, :id, :venue_id, :organization_id, :integer, :name, :description, :text, :url, :cost, :start_date, :end_date, :url, :created_at, :updated_at
json.url event_url(event, format: :json)
