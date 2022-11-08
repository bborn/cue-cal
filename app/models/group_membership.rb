class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :organization_membership

  has_one :user, through: :organization_membership
end
