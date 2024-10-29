class LifetimesController < ApplicationController
  include LifetimesHelper

  def featured
    @featured = Lifetime.all
  end

  def single
    @lifetime = Lifetime.find(params[:id])
    @years = years_from_periods(@lifetime.periods)
    year = params[:year].to_i
    @selected_year = year && @years.include?(year) ? year : @years[0]
    @periods = periods_of_year(@lifetime.periods, @selected_year)
  end
end
