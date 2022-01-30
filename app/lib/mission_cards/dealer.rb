class MissionCards::Dealer
  HAND_LIMIT = 5

  def deal_hands!
    def deal_player_hands!
      # Pilot.active.each do |pilot|
      #   deal_hand_to pilot
      # end
    end

    def deal_squadron_hands!
      # Squadron.active.each do |squadron|
      #   deal_hand_to squadron
      # end
    end

    def deal_hand_to!(dealable)
      # Deal HAND_LIMIT cards to the given polymorphic entity
    end
  end
end