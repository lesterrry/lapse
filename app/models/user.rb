class User < ApplicationRecord
    include ApplicationHelper
    include ImageCompressible

    validates_uniqueness_of :username, allow_nil: true

    validates :email, presence: true, uniqueness: { case_sensitive: false }

    has_many :lifetimes, dependent: :destroy
    has_many :comments, dependent: :nullify
    has_many :likes, dependent: :destroy
    has_many :liked_lifetimes, through: :likes, source: :lifetime
    has_many :savings, dependent: :destroy
    has_many :saved_lifetimes, through: :savings, source: :lifetime
    has_many :active_followings, class_name: 'Following', foreign_key: 'follower_id', dependent: :destroy
    has_many :passive_followings, class_name: 'Following', foreign_key: 'followed_id', dependent: :destroy
    has_many :followings, through: :active_followings, source: :followed
    has_many :followers, through: :passive_followings, source: :follower
    has_many :passkeys, dependent: :destroy

    has_one_attached :profile_picture

    validates :profile_picture, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'], size: { less_than: 1.megabytes }

    devise :passkey_authenticatable, :database_authenticatable, :registerable, :rememberable

    def following?(other_user)
        followings.include?(other_user)
    end

    def followings_count
        followings.count
    end

    def followers_count
        followers.count
    end

    def self.passkeys_class
        Passkey
    end

    def self.find_for_passkey(passkey)
        find_by(id: passkey.user.id)
    end
end

Devise.add_module :passkey_authenticatable,
    model: 'devise/passkeys/model',
    route: { session: [nil, :new, :create, :destroy] },
    controller: 'controller/sessions',
    strategy: true
