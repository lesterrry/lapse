class User < ApplicationRecord
    validates_uniqueness_of :username, allow_nil: true
    validates_uniqueness_of :email

    has_many :lifetimes, dependent: :destroy

    devise :passkey_authenticatable, :database_authenticatable, :registerable, :rememberable

    has_many :passkeys, dependent: :destroy

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
