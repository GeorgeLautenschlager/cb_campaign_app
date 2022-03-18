class Card < ApplicationRecord
  belongs_to :card_template
  belongs_to :pilot

  def self.deal_new_hand
    ['goal', 'modifier', 'buff'].map do |category|
      Card.new card_template: CardTemplate.where(category: category).sample(1).first
    end
  end
end
