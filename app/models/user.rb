class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  def name
    email.split("@").first
  end
end
