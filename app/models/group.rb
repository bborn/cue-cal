class Group < ApplicationRecord
  acts_as_tenant :organization

  has_many :group_memberships, dependent: :destroy

  has_many :memberships, through: :group_memberships, source: :organization_membership
  has_many :users, through: :memberships
end
