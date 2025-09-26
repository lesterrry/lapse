require 'administrate/base_dashboard'

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    active_followings: Field::HasMany,
    comments: Field::HasMany,
    email: Field::String,
    encrypted_password: Field::String,
    first_name: Field::String,
    followers: Field::HasMany,
    followings: Field::HasMany,
    is_admin: Field::Boolean,
    last_name: Field::String,
    lifetimes: Field::HasMany,
    liked_lifetimes: Field::HasMany,
    likes: Field::HasMany,
    passive_followings: Field::HasMany,
    passkeys: Field::HasMany,
    profile_picture_attachment: Field::HasOne,
    profile_picture_blob: Field::HasOne,
    remember_created_at: Field::DateTime,
    remember_token: Field::String,
    saved_lifetimes: Field::HasMany,
    savings: Field::HasMany,
    username: Field::String,
    webauthn_id: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    active_followings
    comments
    email
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    active_followings
    comments
    email
    encrypted_password
    first_name
    followers
    followings
    is_admin
    last_name
    lifetimes
    liked_lifetimes
    likes
    passive_followings
    passkeys
    profile_picture_attachment
    profile_picture_blob
    remember_created_at
    remember_token
    saved_lifetimes
    savings
    username
    webauthn_id
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    active_followings
    comments
    email
    encrypted_password
    first_name
    followers
    followings
    is_admin
    last_name
    lifetimes
    liked_lifetimes
    likes
    passive_followings
    passkeys
    profile_picture_attachment
    profile_picture_blob
    remember_created_at
    remember_token
    saved_lifetimes
    savings
    username
    webauthn_id
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
