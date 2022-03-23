describe MissionCards::CardGenerator do
  subject { MissionCards::CardGenerator.new(card_template, deck_generator) }
  let (:deck_generator) { MissionCards::DeckGenerator.new }
  
  # TODO: No but seriously, shared context plx unt thx
  before do
    create :airforce, :raf
    create :airforce, :usaaf
    create :airforce, :luftwaffe
    
    MissionCards::DeckGenerator.sync_card_templates!
  end

  describe "#plane_options" do
    context "for a level bombing mission" do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'returns the right options based on role' do
        plane_options = subject.plane_options.map{ |plane_option| plane_option["type"] }

        expect(plane_options).to match_array ['a20b']
      end

      it 'returns the right options based on airforce' do
        card_template.update!(airforce: "USAAF")

        plane_options = subject.plane_options.map{ |plane_option| plane_option["type"] }

        expect(plane_options).to match_array []
      end
    end

    context "for a Fighter Sweep" do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }

      it 'returns the right options' do
        plane_options = subject.plane_options.map{ |plane_option| plane_option["type"] }

        expect(plane_options).to match_array ['p51d15', 'p47d22', 'p38j25']
      end
    end

    context "for a Combat Air Patrol" do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: "RAF"}
      
      it 'returns the right options' do
        plane_options = subject.plane_options.map{ |plane_option| plane_option["type"] }

        expect(plane_options).to match_array ['spitfiremkixe', 'p51d15']
      end 
    end
  end

  describe "#areas_of_operation" do
    context 'for a Fighter Sweep' do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }
      
      it 'returns all targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array ["Gladbach Defences", "Cologne Marshaling Yard"]
      end
    end

    context 'for an Industrial Level Bomb mission' do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'returns the right targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array ["Cologne Marshaling Yard"]
      end
    end

    context 'for a Combat Air Patrol' do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: 'USAAF'}

      it 'returns friendly targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array ['5th Armored', '101st Airborne']
      end
    end
  end

  describe "generate_cards!" do
    context "for a CAP" do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: "Luftwaffe" }

      it 'generates all possible missions' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result).to match_array [
          ["Combat Air Patrol", "Gladbach Defences", "Odendorf", "bf109g14"],
          ["Combat Air Patrol", "Cologne Marshaling Yard", "Odendorf", "bf109g14"],
          ["Combat Air Patrol", "Gladbach Defences", "Odendorf", "fw190a8"],
          ["Combat Air Patrol", "Cologne Marshaling Yard", "Odendorf", "fw190a8"],
          ["Combat Air Patrol", "Gladbach Defences", "Kelz", "bf109g14"],
          ["Combat Air Patrol", "Cologne Marshaling Yard", "Kelz", "bf109g14"],
          ["Combat Air Patrol", "Gladbach Defences", "Kelz", "fw190a8"],
          ["Combat Air Patrol", "Cologne Marshaling Yard", "Kelz", "fw190a8"],
        ]
      end
    end

    context "for a Fighter Sweep" do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }

      it 'generates all possible USAAF options' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result).to match_array [
          ["Fighter Sweep", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
          ["Fighter Sweep", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
          ["Fighter Sweep", "Gladbach Defences", "Y-29 Asch FSP", "p47d22"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p47d22"],
          ["Fighter Sweep", "Gladbach Defences", "B-78 Eindhoven BSP", "p38j25"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "p38j25"],
        ]
      end
    end

    context "for a Level Bombing mission" do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'generates all possible USAAF options' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result).to match_array [
          ["Train Yard Level Bomb", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "a20b"]
        ] 
      end
    end
  end
end