class LifetimesController < ApplicationController
  def featured
    @featured = Lifetime.all
    p @featured
  end

  def single
    @lifetime = Lifetime.find_by(title: 'Жизнь моего деда')
  end
end
