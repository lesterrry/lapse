class Users::ProfilesController < ApplicationController
	before_action :authenticate_user!

	def single
		@lifetimes = current_user.lifetimes
	end
end
