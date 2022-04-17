class UsersController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def mulligan
    current_user.raf_pilot.deal_hand!
    current_user.usaaf_pilot.deal_hand!
    current_user.vvs_pilot.deal_hand!
    current_user.luftwaffe_pilot.deal_hand!

    flash[:notice] = "All of your pilots have been dealt new hands."
    redirect_to user_path(current_user)
  end
end