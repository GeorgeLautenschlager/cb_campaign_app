class Card < ApplicationRecord
  belongs_to :card_template
  has_and_belongs_to_many :pilots
  has_one :mission_track

  scope :active, -> { where(active: true) }

  def self.deal_new_hand
    ['goal', 'modifier', 'buff'].map do |category|
      Card.new card_template: CardTemplate.where(category: category).sample(1).first
    end
  end

  def activate!
    update!(active: true)
    MissionTrack.create! card: self
  end

  def pilot
    pilots.first
  end
end
