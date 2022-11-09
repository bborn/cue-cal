class Event < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :production

  has_many :event_groups, dependent: :destroy
  has_many :groups, through: :event_groups

  validates :start_time, :end_time, :name, :production, presence: true
end
