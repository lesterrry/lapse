class Users::ProfilesController < ApplicationController
    include ApplicationHelper

    before_action :authenticate_user!, except: %i[single]

    def me
        @user = current_user

        @lifetimes =
            if @user == current_user
                @user.lifetimes
            else
                @user.lifetimes.where(private: false)
            end

        render :single
    end

    def single
        @user = User.find(params[:id])

        @lifetimes = @user.lifetimes
    end

    def followers
        @user = User.find(params[:id])
        @followers = @user.followers

        render :followers
    end

    def followings
        @user = User.find(params[:id])
        @followings = @user.followings

        render :followings
    end

    def edit
        @user = current_user

        @delete_picture = params['delete-picture']

        @user.profile_picture.purge if @delete_picture
    end

    def update_single
        @user = current_user

        if @user.update(profile_params)
            flash[:notice] = 'Updated your data'
        else
            flash[:alert] = extract_errors(@user)
        end

        redirect_to action: :edit
    end

    private

    def profile_params
        params.require(:user).permit(:first_name, :last_name, :username, :profile_picture)
    end
end
