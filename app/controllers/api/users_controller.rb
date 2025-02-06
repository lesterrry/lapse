class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    include Devise::Controllers::Helpers

    def login
        user = User.find_for_database_authentication(email: params[:email])

        if user&.valid_password?(params[:password])
            render json: { message: 'OK', user: }
        else
            render json: { message: 'Unauthorized' }, status: :unauthorized
        end
    end
end
