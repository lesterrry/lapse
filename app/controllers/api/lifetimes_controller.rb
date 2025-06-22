class Api::LifetimesController < ApplicationController
	before_action :authenticate_user_from_token!
	skip_before_action :verify_authenticity_token

	def index
		lifetimes = Lifetime.all
		render json: lifetimes
	end

	def single
		lifetime = Lifetime.find(params[:id])
		render json: lifetime, include: [:periods]
	end

	def update_single
		lifetime = Lifetime.find(params[:id])

		owned = lifetime.user == current_user

		raise ActiveRecord::RecordInvalid unless owned

		render json: lifetime
	end

	private

	def lifetime_params
		params.require(:lifetime).permit(:title, :description, periods_attributes: %i[id title description color_hex start end _destroy])
	end
end
