class Api::SubscriptionsController < ApplicationController
	before_action :authenticate_user_from_token!
	skip_before_action :verify_authenticity_token

	def create
		subscription = Subscription.new(subscription_params)

		subscription.save

		render json: { message: 'OK' }, status: :created
	end

		private

	def subscription_params
		params.permit(:email)
	end
end
