class Production < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :user

  validates :name, presence: true
end
