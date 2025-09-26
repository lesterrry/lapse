class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_lifetime

    def create
        @like = @lifetime.likes.new(user: current_user)

        @like.save

        redirect_back(fallback_location: root_path)
    end

    def destroy
        @like = @lifetime.likes.find_by(user: current_user)

        @like&.destroy

        redirect_back(fallback_location: root_path)
    end

  private

    def set_lifetime
        @lifetime = Lifetime.find(params[:lifetime_id])
    end
end
