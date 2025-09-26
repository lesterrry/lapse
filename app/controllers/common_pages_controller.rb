class CommonPagesController < ApplicationController
  def index
    @page_nav_name = 'home'

    @top_lifetimes = Lifetime.where(visibility: :everyone).order(view_count: :desc).limit(10)

    @top_users = User.joins(:passive_followings).group('users.id').order('COUNT(followings.id) DESC')
  end

  def promo
    @page_nav_name = 'promo'
  end

  def about
    @page_nav_name = 'about'
  end

  def search; end
end
