class OrganizationMembership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :event_memberships, dependent: :destroy
  has_many :events, through: :event_memberships

  delegate :name, :avatar, to: :user

  def self.find_or_create_by_name(organization, name)
    if user = organization.users.where(name: name).first
      organization.organization_memberships.find_by(user_id: user)
    else
      #invite the user
      user = User.where(name: name).first_or_initialize
      if name.include?("@")
        user.email ||= name
      end
      user.organizations << organization
      user.save!(validate: false)

      user.organization_memberships.find_by(organization_id: organization.id)
    end
  end
end
