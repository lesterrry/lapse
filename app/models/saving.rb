class Saving < ApplicationRecord
  belongs_to :user
  belongs_to :lifetime

  validates :user_id, uniqueness: { scope: :lifetime_id }
end