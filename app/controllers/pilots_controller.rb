class PilotsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_pilot

  def show

  end

  private

  def load_pilot
    @pilot = Pilot.find(params[:id])
  end
end