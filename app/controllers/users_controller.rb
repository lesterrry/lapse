class UsersController < ApplicationController
  def single
    @user = User.find_by(username: 'lesterrry')
  end
end
