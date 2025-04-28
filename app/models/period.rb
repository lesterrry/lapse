class Period < ApplicationRecord
  belongs_to :lifetime

  validates :title, presence: true

  has_many_attached :photos

  default_scope { order('start ASC') }
end
