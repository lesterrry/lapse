class Lifetime < ApplicationRecord
	belongs_to :user

	validates :title, presence: true
	validates :description, presence: true

	has_many :periods, dependent: :destroy
	accepts_nested_attributes_for :periods, allow_destroy: true, reject_if: :all_blank

	has_many :comments, dependent: :nullify
	has_many :likes, dependent: :destroy
	has_many :liking_users, through: :likes, source: :user

	def liked_by?(user)
		likes.exists?(user_id: user&.id)
	end

	def like_count
		likes.count
	end
end
