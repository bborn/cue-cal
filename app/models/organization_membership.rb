class OrganizationMembership < ApplicationRecord
  include ActionText::Attachable

  belongs_to :user
  belongs_to :organization

  has_many :group_memberships, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :event_memberships, dependent: :destroy
  has_many :events, through: :event_memberships

  delegate :name, :avatar, to: :user

  def self.find_or_create_by_name(organization, name)
    email = "#{name.parameterize(separator: ".")}@example.com"
    users = organization.users.where(name: name)
    users = users.or(users.where(email: email))

    if user = users.first
      organization.organization_memberships.find_by(user_id: user)
    else
      user = User.where(name: name, email: email).first_or_initialize
      user.organizations << organization
      user.save!(validate: false)

      user.organization_memberships.find_by(organization_id: organization.id)
    end
  end

  def to_trix_content_attachment_partial_path
    "organization_memberships/shared/label"
  end

  def to_attachable_partial_path
    "organization_memberships/shared/label"
  end
end
