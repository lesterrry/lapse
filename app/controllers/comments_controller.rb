class CommentsController < ApplicationController
    before_action :set_lifetime

    def create
        @comment = @lifetime.comments.new(comment_params)

        @comment.save

        redirect_to single_lifetime_url(@lifetime)
    end

    def destroy
        @comment = @lifetime.comments.find(params[:id])
        @comment.destroy

        redirect_to single_lifetime_url(@lifetime)
    end

    private

    def set_lifetime
        @lifetime = Lifetime.find(params[:lifetime_id])
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
