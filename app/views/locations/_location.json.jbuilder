json.extract! location, :id, :name, :created_at, :updated_at

json.title location.name
json.url location_url(location, format: :json)
json.color location.color

json.extendedProps do
  json.icon location.icon
end
