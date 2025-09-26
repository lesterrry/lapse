module Users
  class ProfilesController < ApplicationController
    include ApplicationHelper

    before_action :authenticate_user!, except: %i[single single_by_username]

    def me
      @user = current_user

      set_lifetimes

      render :single
    end

    def single
      @user = User.find(params[:id])

      set_lifetimes

      # If user has a username, redirect to username-based route
      return unless @user.username.present?

      redirect_to users_single_profile_by_username_path(@user.username)
      nil
    end

    def single_by_username
      @user = User.find_by!(username: params[:username])

      set_lifetimes

      render :single
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

    def set_lifetimes
      @lifetimes =
        if current_user && @user == current_user
          @user.lifetimes
        elsif current_user&.followings&.include?(@user) && @user.followings.include?(current_user)
          @user.lifetimes.where(visibility: :everyone).or(@user.lifetimes.where(visibility: :mutuals_only))
        else
          @user.lifetimes.where(visibility: :everyone)
        end
    end
  end
end
