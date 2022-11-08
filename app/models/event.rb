class Event < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :production
end
