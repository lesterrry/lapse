class Lifetime < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :description, presence: true

	has_many :periods, dependent: :destroy
	accepts_nested_attributes_for :periods, allow_destroy: true, reject_if: :all_blank
end
