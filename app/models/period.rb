class Period < ApplicationRecord
  belongs_to :lifetime

  has_many_attached :photos

  default_scope { order('start ASC') }
end
