class SavingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lifetime, only: %i[create destroy]

  def index
    @saved_lifetimes = current_user.saved_lifetimes
  end

  def create
    @saving = @lifetime.savings.new(user: current_user)

    @saving.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @saving = @lifetime.savings.find_by(user: current_user)

    @saving&.destroy

    redirect_back(fallback_location: root_path)
  end

  private

  def set_lifetime
    @lifetime = Lifetime.find(params[:lifetime_id])
  end
end
