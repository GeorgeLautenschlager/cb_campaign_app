class CardTemplate < ApplicationRecord
  has_many :cards

  def coalition
    airforce.coalition
  end
end
