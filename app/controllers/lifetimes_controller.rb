class LifetimesController < ApplicationController
	include ApplicationHelper
	include LifetimesHelper

	def featured
		@featured = Lifetime.where(private: false)
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
			flash[:alert] = extract_errors(@lifetime)
			redirect_to action: :new
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

		unless can_view_lifetime?(@lifetime)
			flash[:alert] = "You don't have permission to view this lifetime"

			redirect_to root_path and return
		end

		@lifetime.increment_view_count! unless request.headers['HTTP_X_SEC_PURPOSE'] == 'prefetch'

		@years = years_from_periods(@lifetime.periods)
		@owned = @lifetime.user == current_user
		@editable = !params[:edit].nil? && @owned
		@view_mode = params['view-mode']&.to_sym || :donut
		@calendar =
			if params['cal'] == 'c'
				%i[qingming guyu lixia xiaoman mangzhong xiazhi xiaoshu dashu liqiu chushu bailu qiufen hanlu shuangjiang lidong xiaoxue daxue dongzhi xiaohan dahan lichun yushui jingzhe chunfen]
			else # григорианский
				%i[april may june july august september october november december january february march]
			end

		new_period = params[:new] == '1'
		delete_period = params['delete-period']
		delete_period_photo = params['delete-period-photo']
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
		elsif delete_period
			period = @lifetime.periods.find(delete_period)

			raise ActiveRecord::RecordInvalid unless @owned

			period.destroy

			redirect_to set_param(['edit', 1], ['delete-period', nil], current_params: request.query_parameters)
		elsif delete_period_photo
			period = @lifetime.periods.find(delete_period_photo)

			raise ActiveRecord::RecordInvalid unless @owned

			period.photos.purge

			redirect_to set_param(['edit', 1], ['delete-period-photo', nil], current_params: request.query_parameters)
		end
	end

	def update_single
		@lifetime = Lifetime.find(params[:id])

		raise ActiveRecord::RecordInvalid unless @lifetime.user == current_user

		view_mode = params[:lifetime][:view_mode].dup

		if @lifetime.update(lifetime_params)
			redirect_to action: :single, year: params[:year], 'view-mode': view_mode
		else
			flash[:alert] = extract_errors(@lifetime)
			redirect_to action: :single, year: params[:year], 'view-mode': view_mode, 'edit': 1
		end
	end

	private

	def can_view_lifetime?(lifetime)
		!lifetime.private? || lifetime.user == current_user
	end

	def permit_lifetime_params(params)
		if params[:lifetime][:periods_attributes].present?
			params[:lifetime][:periods_attributes].each_value do |period|
				period.delete(:photos) if period[:photos] == ['']
			end
		end

		params.require(:lifetime).permit(:title, :description, :start_point, :finish_point, :private, periods_attributes: [:id, :title, :description, :color_hex, :start, :end, { photos: [] }])
	end

	def lifetime_params
		permit_lifetime_params(params)
	end
end
