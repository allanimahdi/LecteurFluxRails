json.extract! entry, :id, :title, :pulished, :content, :url, :lu, :created_at, :updated_at
json.url entry_url(entry, format: :json)
