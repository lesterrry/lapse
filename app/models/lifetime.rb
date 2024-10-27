class Lifetime < ApplicationRecord
	belongs_to :user
	has_many :periods, dependent: :destroy
end
