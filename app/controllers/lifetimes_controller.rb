class LifetimesController < ApplicationController
	include LifetimesHelper

	def featured
		@featured = Lifetime.all
	end

	def new
		@lifetime = Lifetime.new
	end

	def single
		@lifetime = Lifetime.find(params[:id])
		@years = years_from_periods(@lifetime.periods)
		@editable = !params[:edit].nil?
		@view_mode = params['view-mode']&.to_sym || :donut
		new_period = !params[:new].nil?

		year = params[:year].to_i
		@selected_year = year && @years.include?(year) ? year : @years.last

		@periods =
			if @view_mode == :donut
				periods_of_year(@lifetime.periods, @selected_year)
			else
				@lifetime.periods
			end

		if new_period
			@lifetime.periods.create({ title: 'New period', description: 'description', start: Date.new(@selected_year, 1, 1), end: Date.new(@selected_year, 1, 1) })
			redirect_to set_param(['edit', 1], ['new', nil], current_params: request.query_parameters)
		end
	end

	def update_single
		@lifetime = Lifetime.find(params[:id])

		view_mode = params[:lifetime][:view_mode].dup

		@lifetime.update(lifetime_params)

		redirect_to action: :single, year: params[:year], 'view-mode': view_mode
	end

	private

	def lifetime_params
		params.require(:lifetime).permit(:title, :description, periods_attributes: %i[id title description color_hex start end _destroy])
	end
end
