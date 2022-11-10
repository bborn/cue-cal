class Production < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :user

  has_many :groups, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true
end
