class CardsController < ApplicationController
  before_action :load_card
  before_action :authenticate_user!

  def show

  end

  private

  def load_card
    @card = Card.find(params[:id])
  end
end