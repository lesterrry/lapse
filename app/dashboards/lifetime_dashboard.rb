require "administrate/base_dashboard"

class LifetimeDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    comments: Field::HasMany,
    description: Field::String,
    finish_point: Field::String,
    likes: Field::HasMany,
    liking_users: Field::HasMany,
    periods: Field::HasMany,
    private: Field::Boolean,
    savings: Field::HasMany,
    start_point: Field::String,
    title: Field::String,
    user: Field::BelongsTo,
    view_count: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    comments
    description
    finish_point
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    id
    comments
    description
    finish_point
    likes
    liking_users
    periods
    private
    savings
    start_point
    title
    user
    view_count
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
    comments
    description
    finish_point
    likes
    liking_users
    periods
    private
    savings
    start_point
    title
    user
    view_count
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

  # Overwrite this method to customize how lifetimes are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(lifetime)
  #   "Lifetime ##{lifetime.id}"
  # end
end
