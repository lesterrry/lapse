class LifetimesController < ApplicationController
	include LifetimesHelper

	def featured
		@featured = Lifetime.all
	end

	def single
		@lifetime = Lifetime.find(params[:id])
		@years = years_from_periods(@lifetime.periods)
		@editable = !params[:edit].nil?
		@view_mode = params['view-mode']&.to_sym || :donut

		year = params[:year].to_i
		@selected_year = year && @years.include?(year) ? year : @years[0]
		@periods = periods_of_year(@lifetime.periods, @selected_year)

		new_period = !params[:new].nil?

		if new_period
			@lifetime.periods.create({ title: 'New period', description: 'description', start: Date.new(@selected_year, 1, 1), end: Date.new(@selected_year, 1, 1) })
			redirect_to "#{request.base_url}#{request.path}?edit=1"
		end
	end

	def update_single
		@lifetime = Lifetime.find(params[:id])

		@lifetime.update(lifetime_params)

		redirect_to action: :single, year: params[:year]
	end

	private

	def lifetime_params
		params.require(:lifetime).permit(:title, :description, periods_attributes: %i[id title description start end _destroy])
	end
end
