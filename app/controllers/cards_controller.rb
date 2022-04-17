class CardsController < ApplicationController
  before_action :load_card

  def show

  end

  private

  def load_card
    @card = Card.find(params[:id])
  end
end