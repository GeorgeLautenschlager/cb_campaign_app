class UsersController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def mulligan
    current_user.deal_new_hand!
    redirect_to user_path(current_user)
  end
end