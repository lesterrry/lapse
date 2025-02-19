class Api::LifetimesController < ApplicationController
	def index
		@all = Lifetime.all
		render json: @all, include: [:periods]
	end

	def single
		@lifetime = Lifetime.find(params[:id])
		render json: @lifetime, include: [:periods]
	end
end
