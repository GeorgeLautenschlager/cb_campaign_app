describe MissionCards::DeckGenerator do
  include_context "app config"

  subject { MissionCards::DeckGenerator.new(MissionCards::DeckConfiguration.new) }

  describe 'loading deck config' do
    it 'provides actionable targets' do
      attackable_targets = subject.attackable_targets('allied').keys

      expect(attackable_targets).to match_array [
        "bases", "industrial buildings", "trains", 
        "ground units", "bridges", "tanks", "coastal logistics"
      ]
    end

    it 'provides available planes' do
      available_planes = subject.available_planes(raf).keys

      expect(available_planes).to match_array ["a20b", "p47d22", "p51b5", "spitfiremkixe", "typhoonmkib"]
    end
  end

  describe 'selecting card templates' do
    it 'selects the right card templates' do
      expect(subject.actionable_card_templates(raf).map(&:title)).to match_array [
        "Factory Strike", "Industrial Attack", "Petrol Attack", "Bridge Attack",
        "Train Hunter", "Fighter Bomber Attack", "Ship Attack",  "Tank Busters",
        "Industrial Level Bomb", "Petrol Level Bomb", "Bridge Level Bomb",
        "Train Yard Level Bomb", "Ship Level Bomb", "Tank Level Bomb", "Recon",
        "Defend Industry", "Safeguard Ships", "Combat Air Patrol", "Fighter Sweep",
        "Bomber Interdiction", "Close Air Support", "Free Hunt"
        ]
    end
  end

  describe '#generate_for_airforce!' do
    it 'populates the cards table for the given airforce' do
      cards = subject.generate_for_airforce!(raf)
      result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

      expect(result.length).to eq(656)
    end
  end

  describe '#generate!' do
    it 'populates the cards table for all airforces' do
      cards = subject.generate!
      result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

      # TODO: Use a dummy protobuff config.
      # Even one form the small velikie campaign generates too many options at the moment to be used for testing
      expect(result.length).to eq 4788
    end
  end
end