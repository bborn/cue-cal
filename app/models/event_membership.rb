class EventMembership < ApplicationRecord
  belongs_to :organization_membership
  belongs_to :event

  validates :organization_membership, :event, presence: true
end
