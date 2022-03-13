describe MissionCards::CardGenerator do
  subject { MissionCards::CardGenerator.new(card_template, available_planes, actionable_targets) }

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
      {"type"=>"ground units", "areas_of_operation"=>["Gladbach Defences"]},
      {"type"=>"industrial buildings", "areas_of_operation"=>["Cologne Marshaling Yard"]}
    ]
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
end