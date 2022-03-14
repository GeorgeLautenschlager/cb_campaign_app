describe MissionCards::CardGenerator do
  subject { MissionCards::CardGenerator.new(card_template, available_planes, actionable_targets, user) }

  let(:available_planes) do
    [
      {
        "type"=>"p51d15",
        "loadouts"=>"1..10",
        "airfields"=>[
          {"name"=>"B-78 Eindhoven FSP", "airforce"=>"RAF"},
          {"name"=>"Y-29 Asch FSP", "airforce"=>"USAAF"}
        ]
      },
      {
        "type"=>"p47d22", 
        "loadouts"=>"1..10", 
        "airfields"=>[
          {"name"=>"Y-29 Asch FSP", "airforce"=>"USAAF"}
        ]
      },
      {
        "type"=>"spitfiremkixe", 
        "loadouts"=>"1..10", 
        "airfields"=>[
          {"name"=>"B-78 Eindhoven FSP", "airforce"=>"RAF"}
        ]
      },
      {
        "type"=>"p38j25",
        "loadouts"=>"1..10",
        "airfields"=>[
          {"name"=>"B-78 Eindhoven BSP", "airforce"=>"USAAF"}
        ]
      },
      {
        "type"=>"a20b",
        "loadoots"=>"1..10",
        "airfields"=>[
          {"name"=>"B-78 Eindhoven BSP", "airforce"=>"RAF"}
        ]
      }
    ]
  end

  let(:actionable_targets) do
    [
      {"type"=>"ground units", "areas_of_operation"=>["Gladbach Defences", "Tilburg Defences"]},
      {"type"=>"industrial buildings", "areas_of_operation"=>["Cologne Marshaling Yard"]},
      {"type"=>"trains", "areas_of_operation"=>["Cologne Marshaling Yard"]},
    ]
  end

  let(:user) do
    User.create! email: "please_make_me@a_pilot.com", password: "but later, I guess"
  end
  
  # TODO: No but seriously, shared context plx unt thx
  before do
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
  end

  describe "#areas_of_operation" do
    context 'for a Fighter Sweep' do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }
      
      it 'returns all targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match ["Gladbach Defences", "Tilburg Defences", "Cologne Marshaling Yard"]
      end
    end

    context 'for an Industrial Level Bomb mission' do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'returns the right targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match ["Cologne Marshaling Yard"]
      end
    end
  end

  describe "generate_cards!" do
    context "for a Fighter Sweep" do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }

      it 'generates all possible USAAF options' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result).to match_array [
          ["Fighter Sweep", "Gladbach Defences", "B-78 Eindhoven FSP", "p51d15"],
          ["Fighter Sweep", "Gladbach Defences", "Y-29 Asch FSP", "p51d15"],
          ["Fighter Sweep", "Tilburg Defences", "B-78 Eindhoven FSP", "p51d15"],
          ["Fighter Sweep", "Tilburg Defences", "Y-29 Asch FSP", "p51d15"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "B-78 Eindhoven FSP", "p51d15"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p51d15"],
          ["Fighter Sweep", "Gladbach Defences", "Y-29 Asch FSP", "p47d22"],
          ["Fighter Sweep", "Tilburg Defences", "Y-29 Asch FSP", "p47d22"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "Y-29 Asch FSP", "p47d22"],
          ["Fighter Sweep", "Gladbach Defences", "B-78 Eindhoven BSP", "p38j25"],
          ["Fighter Sweep", "Tilburg Defences", "B-78 Eindhoven BSP", "p38j25"],
          ["Fighter Sweep", "Cologne Marshaling Yard", "B-78 Eindhoven BSP", "p38j25"]
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