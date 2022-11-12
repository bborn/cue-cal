class Location < ApplicationRecord
  has_many :event_locations, dependent: :destroy
  has_many :events, through: :event_locations
  acts_as_tenant :organization
end
