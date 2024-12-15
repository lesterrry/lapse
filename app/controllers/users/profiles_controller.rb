class Users::ProfilesController < ApplicationController
  before_action :authenticate_user!

  def me; end
end
