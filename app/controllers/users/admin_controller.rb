class Users::AdminController < ApplicationController
    before_action :authenticate_user!, :verify_admin

    def index; end

    protected

    def verify_admin
        redirect_to root_url unless current_user.is_admin?
    end
end
