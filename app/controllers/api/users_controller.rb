class Api::UsersController < ApplicationController
    before_action :authenticate_user_from_token!, except: %i[login signup]
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

    def signup
        user = User.new(user_params)

        if user.save
            render json: { message: 'OK', token: generate_token(user.id), user: }, status: :created
        else
            render json: { message: 'Error', error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def index
        users = User.all

        render json: users.to_json(methods: [:followers_count])
    end

    def single
        user = User.find(params[:id])

        render json: user.to_json(methods: [:followers_count])
    end

    def lifetimes
        user = User.find(params[:id])

        render json: user.lifetimes, status: :created
    end

    private

    def generate_token(user_id)
        JWT.encode({ user_id: }, Rails.application.secret_key_base)
    end

    def user_params
        params.permit(:email, :password, :username, :profile_picture)
    end
end
