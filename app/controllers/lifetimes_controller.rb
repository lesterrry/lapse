class LifetimesController < ApplicationController
	include LifetimesHelper

	def featured
		@featured = Lifetime.all
	end

	def new
		@lifetime = Lifetime.new

		@hide_footer = true
	end

	def create
		@lifetime = Lifetime.new(lifetime_params)
		@lifetime.user = current_user

		if @lifetime.save
			redirect_to action: :single, id: @lifetime.id, 'view-mode': :list, edit: true
		else
			flash[:alert] = @lifetime.errors.full_messages.to_sentence
			render :new
		end
	end

	def destroy
		@lifetime = Lifetime.find(params[:id])

		@owned = @lifetime.user == current_user

		raise ActiveRecord::RecordInvalid unless @owned

		@lifetime.destroy

		redirect_to my_profile_path
	end

	def single
		@lifetime = Lifetime.find(params[:id])

		@years = years_from_periods(@lifetime.periods)
		@owned = @lifetime.user == current_user
		@editable = !params[:edit].nil? && @owned
		@view_mode = params['view-mode']&.to_sym || :donut

		new_period = params[:new] == '1'
		year = params[:year].to_i

		@selected_year =
			if year && @years.include?(year)
				year
			elsif !@years.empty?
				@years.last
			else
				Time.now.year
			end

		index = @years.index(@selected_year) || 0

		@previous_year = index.positive? ? @years[index - 1] : nil
		@next_year = @years[index + 1]

		p index, @previous_year, @next_year

		@periods =
			if @view_mode == :donut
				periods_of_year(@lifetime.periods, @selected_year)
			else
				@lifetime.periods
			end

		if new_period
			raise ActiveRecord::RecordInvalid unless @owned

			@lifetime.periods.create({ title: '', description: '', start: Date.new(@selected_year, 1, 1), end: Date.new(@selected_year, 1, 2) })
			redirect_to set_param(['edit', 1], ['new', nil], current_params: request.query_parameters)
		end
	end

	def update_single
		@lifetime = Lifetime.find(params[:id])

		raise ActiveRecord::RecordInvalid unless @lifetime.user == current_user

		view_mode = params[:lifetime][:view_mode].dup

		if @lifetime.update(lifetime_params)
			redirect_to action: :single, year: params[:year], 'view-mode': view_mode
		else
			flash[:alert] = @lifetime.errors.full_messages.to_sentence
			redirect_to action: :single, year: params[:year], 'view-mode': view_mode, 'edit': 1
		end
	end

	private

	def permit_lifetime_params(params)
		if params[:lifetime][:periods_attributes].present?
			params[:lifetime][:periods_attributes].each_value do |period|
				period.delete(:photos) if period[:photos] == ['']
			end
		end

		params.require(:lifetime).permit(:title, :description, periods_attributes: [:id, :title, :description, :color_hex, :start, :end, :_destroy, { photos: [] }])
	end

	def lifetime_params
		permit_lifetime_params(params)
	end
end
