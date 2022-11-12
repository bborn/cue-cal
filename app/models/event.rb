class Event < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :production

  has_many :event_groups, dependent: :destroy
  has_many :groups, through: :event_groups

  has_many :event_locations, dependent: :destroy
  has_many :locations, through: :event_locations

  validates :start_time, :end_time, :name, :production, presence: true

  scope :today, -> { order(start_time: :asc).where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  after_save_commit {
    production.broadcast_replace_to production, target: :first_calls, partial: "productions/first_calls", locals: { production: production }
    ActionCable.server.broadcast("calendar_channel", { event: self })
  }

  after_destroy_commit {
    production.broadcast_replace_to production, target: :first_calls, partial: "productions/first_calls", locals: { production: production }
    ActionCable.server.broadcast("calendar_channel", { event: self })
  }

  def icons
    (groups.map(&:icon) | locations.map(&:icon)).uniq.compact
  end

  def first_user_calls
  end

  # def textColor
  #   # "#999999"
  # end

  # def backgroundColor
  #   # "#efefef"
  # end

  # def borderColor
  #   # "#999999"
  # end
end
