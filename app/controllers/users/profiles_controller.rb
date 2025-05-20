class Users::ProfilesController < ApplicationController
	before_action :authenticate_user!, only: [:me]

	def me
		@user = current_user

		@lifetimes = @user.lifetimes

		render :single
	end

	def single
		@user = User.find(params[:id])

		@lifetimes = @user.lifetimes
	end
end
