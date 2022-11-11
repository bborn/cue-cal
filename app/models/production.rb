class Production < ApplicationRecord
  acts_as_tenant :organization

  belongs_to :user

  has_many :groups, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true

  def first_user_calls
    user_calls = {}

    groups.each { |group|
      if first_call = group.first_call
        group.users.each { |user|
          user_calls[user] = first_call
        }
      end
    }

    user_calls = user_calls.sort_by { |user, call| user.name }
  end
end
