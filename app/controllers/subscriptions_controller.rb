class SubscriptionsController < ApplicationController
	def create
		@subscription = Subscription.new(subscription_params)

		if @subscription.save
			redirect_to root_path, notice: 'Спасибо за подписку!'
		else
			redirect_to root_path, notice: 'Ошибка при добавлении адреса :('
		end
	end

		private

	def subscription_params
		params.require(:subscription).permit(:email)
	end
end
