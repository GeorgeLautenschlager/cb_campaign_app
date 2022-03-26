describe MissionCards::DeckGenerator do
  include_context "app config"

  subject { MissionCards::DeckGenerator.new }

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
    it 'populates the cards table for the given airforce' do
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
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"]
      ]
    end
  end

  describe '#generate!' do
    it 'populates the cards table for all airforces' do
      cards = subject.generate!
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
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Fighter Bomber Attack", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Industrial Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "spitfiremkixe"],
        ["Factory Strike", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Factory Strike", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Factory Strike", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p47d22"],
        ["Factory Strike", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "p38j25"],
        ["Industrial Attack", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Industrial Attack", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Industrial Attack", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p47d22"],
        ["Industrial Attack", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "p38j25"],
        ["Train Hunter", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
        ["Train Hunter", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
        ["Train Hunter", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p47d22"],
        ["Train Hunter", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "p38j25"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
        ["Close Air Support", "Gladbach Defences", "Y-29 Asch FSP", "p47d22"],
        ["Close Air Support", "Gladbach Defences", "B-78 Eindhoven BSP", "p38j25"],
        ["Tank Busters", "5th Armored", "Odendorf", "fw190a8"],
        ["Tank Busters", "5th Armored", "Kelz", "fw190a8"],
        ["Tank Busters", "5th Armored", "Odendorf", "bf109g14"],
        ["Tank Busters", "5th Armored", "Kelz", "bf109g14"],
        ["Tank Busters", "5th Armored", "Ulmen Air Spawn", "he111h16"],
        ["Tank Level Bomb", "5th Armored", "Ulmen Air Spawn", "he111h16"],
        ["Close Air Support", "101st Airborne", "Odendorf", "fw190a8"],
        ["Close Air Support", "101st Airborne", "Kelz", "fw190a8"],
        ["Close Air Support", "101st Airborne", "Odendorf", "bf109g14"],
        ["Close Air Support", "101st Airborne", "Kelz", "bf109g14"]
      ]
    end
  end
end