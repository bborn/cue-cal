class GroupMembership < ApplicationRecord
  belongs_to :group
  belongs_to :organization_membership

  has_one :user, through: :organization_membership

  attr_accessor :user_email, :user_name
end
