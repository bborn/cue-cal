class Organization < ApplicationRecord
  has_many :organization_memberships
  has_many :users, through: :organization_memberships

  has_many :productions
  has_many :groups
end
