json.extract! event, :id, :start_time, :end_time, :name, :production_id, :created_at, :updated_at
json.start event.start_time
json.end event.end_time
json.title event.name
json.resourceIds event.location_ids

json.resourceId 0 if event.location_ids.empty?

json.extendedProps do
  json.groups event.groups
  json.locations event.locations
end

json.description event.description.body
json.url resource_url(event)

# json.extract! event, :backgroundColor, :textColor, :borderColor
