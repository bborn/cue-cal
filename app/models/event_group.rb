class EventGroup < ApplicationRecord
  belongs_to :event
  belongs_to :group

  validates :event, :group, presence: true
end
