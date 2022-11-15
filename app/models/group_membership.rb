class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :organization_membership

  has_one :user, through: :organization_membership

  attr_accessor :user_email, :user_name

  delegate :name, to: :user, prefix: true, allow_nil: true
end
