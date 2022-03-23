describe MissionCards::DeckGenerator do
  subject { MissionCards::DeckGenerator.new }

  before do
    MissionCards::DeckGenerator.sync_card_templates!
  end

  let (:raf) do
    create :airforce, :raf
  end

  describe 'loading deck config' do
    it 'provides actionable targets' do
      # TODO: All this faffing about with types would be alleviated with... objects.
      attackable_targets = subject.attackable_targets('allies').map { |target_config| target_config['type'] }
      expect(attackable_targets).to match_array ['ground units', 'industrial buildings', 'trains']
    end

    it 'provides available planes' do
      available_planes = subject.available_planes(raf).map { |plane_config| plane_config['type'] }
      expect(available_planes).to match_array ['p51d15', 'spitfiremkixe', 'a20b']
    end
  end

  describe 'selecting card templates' do
    it 'selects the right card templates' do
      expect(subject.actionable_card_templates(raf).map(&:title)).to match_array [
        "Close Air Support",
        "Factory Strike",
        "Fighter Bomber Attack",
        "Industrial Attack",
        "Industrial Level Bomb",
        "Train Hunter",
        "Train Yard Level Bomb",
      ]
    end
  end

  describe '#generate_for_airforce!' do
    it 'populates the cards table' do
      cards = subject.generate_for_airforce!(raf)
      result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

      expect(result).to match_array [
        ["Factory Strike", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Factory Strike", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Factory Strike", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Factory Strike", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Industrial Attack", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Industrial Attack", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Industrial Attack", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Industrial Attack", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Train Hunter", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Train Hunter", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Train Hunter", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Train Hunter", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven BSP", "a20b"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven BSP", "a20b"]
      ]
    end
  end
end