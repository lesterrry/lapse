class Api::CommentsController < ApplicationController
    before_action :authenticate_user_from_token!
    skip_before_action :verify_authenticity_token

    def create
        lifetime = Lifetime.find(params[:lifetime_id])
        comment = lifetime.comments.build(comment_params)
        comment.user = current_user

        comment.save

        render json: { message: 'OK', comment: }, status: :created
    end

    def destroy
        comment = Comment.find(params[:id])
        owned = comment.user == current_user

        raise ActiveRecord::RecordInvalid unless owned

        comment.destroy

        render json: { message: 'OK' }
    end

    private

    def comment_params
        params.require(:comment).permit(:content)
    end
end
