json.extract! event, :id, :start_time, :end_time, :name, :description, :production_id, :created_at, :updated_at
json.start event.start_time
json.end event.end_time
json.title event.name
json.url event_url(event)
