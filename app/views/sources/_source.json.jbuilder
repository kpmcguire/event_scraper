json.extract! source, :id, :type, :feed_url, :lookup_id, :lookup_name, :lookup_description, :lookup_url, :lookup_cost, :lookup_start_time, :lookup_end_time, :created_at, :updated_at
json.url source_url(source, format: :json)
