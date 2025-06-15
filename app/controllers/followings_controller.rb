class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:id])

    current_user.followings << @user unless self == @user || !@user

    redirect_to users_single_profile_url(id: @user.id)
  end

  def destroy
    @user = User.find(params[:id])

    current_user.followings.delete(@user) if @user

    redirect_to users_single_profile_url(id: @user.id)
  end
end
