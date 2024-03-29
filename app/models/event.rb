class Event < ApplicationRecord
  has_rich_text :description
  acts_as_tenant :organization

  belongs_to :production

  has_many :event_groups, dependent: :destroy
  has_many :groups, through: :event_groups

  has_many :event_locations, dependent: :destroy
  has_many :locations, through: :event_locations

  has_many :event_memberships, dependent: :destroy
  has_many :organization_memberships, through: :event_memberships
  has_many :users, through: :organization_memberships

  validates :start_time, :end_time, :name, :production, presence: true

  scope :today, -> { order(start_time: :asc).where(start_time: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

  # scope for events between a start and end date
  scope :between, ->(start_time, end_time) {
          where("start_time >= ? AND end_time <= ?", start_time, end_time)
        }

  def self.on(date)
    between(date.beginning_of_day, date.end_of_day)
  end

  attr_accessor :group_names, :user_names

  before_save :create_groups_from_group_names
  before_save :create_users_from_user_names

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

  def group_ids=(array)
    ids, group_names = array.partition { |id|
      id.to_i != 0
    }

    self.group_names = group_names.reject(&:blank?)

    super(ids.compact)
  end

  def create_groups_from_group_names
    # if there are group_names, create groups and add them to the event
    if group_names.present?
      group_names.each do |name|
        group = production.groups.where(name: name).first_or_create
        groups << group
      end
    end
  end

  def organization_membership_ids=(array)
    ids, user_names = array.partition { |id|
      id.to_i != 0
    }

    self.user_names = user_names.reject(&:blank?)

    super(ids.compact)
  end

  def create_users_from_user_names
    if user_names.present?
      user_names.each do |name|
        organization_membership = OrganizationMembership.find_or_create_by_name(organization, name)
        organization_memberships << organization_membership
      end
    end
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
