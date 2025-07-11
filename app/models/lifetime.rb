class Lifetime < ApplicationRecord
  include ImageCompressible

  belongs_to :user

  validates :title, presence: true

  has_many :periods, dependent: :destroy
  accepts_nested_attributes_for :periods, allow_destroy: true, reject_if: :all_blank

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :savings, dependent: :destroy

  def saved_by?(user)
    savings.exists?(user_id: user&.id)
  end

  def liked_by?(user)
    likes.exists?(user_id: user&.id)
  end

  def like_count
    likes.count
  end

  def all_photos
    photos = periods.includes(photos_attachments: :blob).flat_map(&:photos)
    compressed_collection(photos)
  end

  def increment_view_count!
    increment!(:view_count)
  end
end
