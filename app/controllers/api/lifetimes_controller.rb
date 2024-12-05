class Api::LifetimesController < ApplicationController
	def index
		@all = Lifetime.all
		render json: @all
	end

	def single
		@lifetime = Lifetime.find(params[:id])
		render json: @lifetime
	end
end
