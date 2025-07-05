class Period < ApplicationRecord
  include ImageCompressible

  belongs_to :lifetime

  has_many_attached :photos

  default_scope { order('start ASC') }
end
