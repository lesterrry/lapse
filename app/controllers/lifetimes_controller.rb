class LifetimesController < ApplicationController
  def featured
    @featured = Lifetime.all
  end

  def single
    @lifetime = Lifetime.find_by(title: 'Жизнь моего деда')
  end
end
