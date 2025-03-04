class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    include Devise::Controllers::Helpers

    def login
        user = User.find_for_database_authentication(email: params[:email])

        if user&.valid_password?(params[:password])
            render json: { message: 'OK', token: generate_token(user.id), user: }
        else
            render json: { message: 'Unauthorized' }, status: :unauthorized
        end
    end

    private

    def generate_token(user_id)
        JWT.encode({ user_id: }, Rails.application.secret_key_base)
    end
end
