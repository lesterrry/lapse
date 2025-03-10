class Comment < ApplicationRecord
  belongs_to :lifetime
  validates :content, presence: true, length: { minimum: 2 }
end
