class Api::LifetimesController < ApplicationController
	before_action :authenticate_user_from_token!

	def index
		@all = Lifetime.all
		render json: @all, include: [:periods]
	end

	def single
		@lifetime = Lifetime.find(params[:id])
		render json: @lifetime, include: [:periods]
	end
end
