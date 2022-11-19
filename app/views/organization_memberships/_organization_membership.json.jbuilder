json.extract! organization_membership, :id, :user_id, :organization_id, :created_at, :updated_at
json.url organization_membership_url(organization_membership, format: :json)

json.name organization_membership.name
json.avatar organization_membership.avatar
