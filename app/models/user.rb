class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  validates :email, presence: true

  def name
    read_attribute(:name).blank? ? email.split("@").first : read_attribute(:name)
  end
end
