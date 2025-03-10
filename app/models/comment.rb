class Comment < ApplicationRecord
  belongs_to :lifetime
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2 }
end
