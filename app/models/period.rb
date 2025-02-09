class Period < ApplicationRecord
  belongs_to :lifetime

  default_scope { order('start ASC') }
end
