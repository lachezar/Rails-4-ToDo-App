json.array!(@tags) do |tag|
  json.extract! tag, :name, :task_id
  json.url tag_url(tag, format: :json)
end