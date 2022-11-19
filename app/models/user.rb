class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  has_many :productions

  validates :email, presence: true, if: :email_required?
  validates :name, presence: true, if: :name_required?

  after_create_commit {
    ActionCable.server.broadcast("calendar_channel", { event: self })
  }

  after_destroy_commit {
    ActionCable.server.broadcast("calendar_channel", { event: self })
  }

  def name
    read_attribute(:name).blank? ? email.split("@").first : read_attribute(:name)
  end

  def avatar
    Initials.svg(name, shape: :rect)
  end

  def email_required?
    name.blank?
  end

  def name_required?
    email.blank?
  end
end
