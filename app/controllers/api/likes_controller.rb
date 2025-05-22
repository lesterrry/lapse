class Api::LikesController < ApplicationController
    before_action :authenticate_user_from_token!
    skip_before_action :verify_authenticity_token

    def create
        lifetime = Lifetime.find(params[:lifetime_id])
        like = lifetime.likes.new(user: current_user)

        like.save

        render json: { message: 'OK' }, status: :created
    end

    def destroy
        lifetime = Lifetime.find(params[:lifetime_id])
        like = lifetime.likes.find_by(user: current_user)

        like&.destroy

        render json: { message: 'OK' }
    end
end
