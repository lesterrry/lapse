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

		@editable = !params[:edit].nil?
	end

	def update_single
		@lifetime = Lifetime.find(params[:id])

		if @lifetime.update(lifetime_params)
			redirect_to action: :single, year: params[:year]
		else
			# render :single
		end
	end

	private

	def lifetime_params
		params.require(:lifetime).permit(:title, :description, periods_attributes: %i[id title description _destroy])
	end
end
