class Group < ApplicationRecord
  acts_as_tenant :organization

  has_many :group_memberships, dependent: :destroy

  has_many :memberships, through: :group_memberships, source: :organization_membership
  has_many :users, through: :memberships

  has_many :event_groups, dependent: :destroy
  has_many :events, through: :event_groups

  belongs_to :production
  # def production_id
  #   production.try(:id)
  # end

  # def production_id=(id)
  #   raise id
  #   self.production_ids = [id]
  # end

  # Ex:- scope :active, -> {where(:active => true)}]
end
