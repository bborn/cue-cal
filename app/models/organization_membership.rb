class OrganizationMembership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships
end
