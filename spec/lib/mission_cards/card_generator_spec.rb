describe MissionCards::CardGenerator do
  include_context "app config"
  
  subject { MissionCards::CardGenerator.new(card_template, deck_generator) }
  let (:deck_generator) { MissionCards::DeckGenerator.new(MissionCards::DeckConfiguration.new) }

  describe "#plane_options" do
    context "for a level bombing mission" do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'returns the right options based on role' do
        plane_options = subject.plane_options.keys

        expect(plane_options).to match_array ['a20b']
      end

      it 'returns the right options based on airforce' do
        card_template.update!(airforce: "VVS")

        plane_options = subject.plane_options.keys

        expect(plane_options).to match_array []
      end
    end

    context "for a Fighter Sweep" do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }

      it 'returns the right options' do
        plane_options = subject.plane_options.keys

        expect(plane_options).to match_array ['p51b5', 'p47d22', 'p38j25']
      end
    end

    context "for a Combat Air Patrol" do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: "RAF"}
      
      it 'returns the right options' do
        plane_options = subject.plane_options.keys

        expect(plane_options).to match_array ["p47d22", "p51b5", "spitfiremkixe", "typhoonmkib"]
      end 
    end
  end

  describe "#areas_of_operation" do
    context 'for a Fighter Sweep' do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }
      
      it 'returns all targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array [
          "Bubnova Rail", "Kamenka Defenses", "Manistrova Rail Yard",
          "Philiptsevo Armored D", "Rojnova Bridges", "Sopki Railyard",
          "Toropets Rail", "Veliki Rail Terminal", "Zaluchie Shipping"
        ]
      end
    end

    context 'for an Industrial Level Bomb mission' do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "RAF" }

      it 'returns the right targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array [
          "Bubnova Rail", "Manistrova Rail Yard", "Sopki Railyard", 
          "Toropets Rail", "Veliki Rail Terminal"
        ]
      end
    end

    context 'for a Combat Air Patrol' do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: 'USAAF'}

      it 'returns friendly targets' do
        areas_of_operation = subject.areas_of_operation

        expect(areas_of_operation).to match_array [
          "Bubnova Rail", "Kamenka Defenses", "Manistrova Rail Yard",
          "Philiptsevo Armored D", "Rojnova Bridges", "Sopki Railyard",
          "Toropets Rail", "Veliki Rail Terminal", "Zaluchie Shipping"
        ]
      end
    end
  end

  describe "generate_cards!" do
    context "for a CAP" do
      let(:card_template) { CardTemplate.find_by title: "Combat Air Patrol", airforce: "Luftwaffe" }

      it 'generates all possible missions' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result.length).to eq 432
      end
    end

    context "for a Fighter Sweep" do
      let(:card_template) { CardTemplate.find_by title: "Fighter Sweep", airforce: "USAAF" }

      it 'generates all possible USAAF options' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result.length).to eq 72
      end
    end

    context "for a Level Bombing mission" do
      let(:card_template) { CardTemplate.find_by title: "Train Yard Level Bomb", airforce: "USAAF" }

      it 'generates all possible USAAF options' do
        cards = subject.generate_cards!
        result = cards.map { |card| [card.title, card.area_of_operation, card.airfield, card.plane] }

        expect(result).to match_array [
          ["Train Yard Level Bomb", "Veliki Rail Terminal", "Kochegarovo", "a20b"],
          ["Train Yard Level Bomb", "Veliki Rail Terminal", "Nevel", "a20b"],
          ["Train Yard Level Bomb", "Veliki Rail Terminal", "Porechye", "a20b"],
          ["Train Yard Level Bomb", "Veliki Rail Terminal", "Drozdova", "a20b"],
          ["Train Yard Level Bomb", "Sopki Railyard", "Kochegarovo", "a20b"],
          ["Train Yard Level Bomb", "Sopki Railyard", "Nevel", "a20b"],
          ["Train Yard Level Bomb", "Sopki Railyard", "Porechye", "a20b"],
          ["Train Yard Level Bomb", "Sopki Railyard", "Drozdova", "a20b"],
          ["Train Yard Level Bomb", "Toropets Rail", "Kochegarovo", "a20b"],
          ["Train Yard Level Bomb", "Toropets Rail", "Nevel", "a20b"],
          ["Train Yard Level Bomb", "Toropets Rail", "Porechye", "a20b"],
          ["Train Yard Level Bomb", "Toropets Rail", "Drozdova", "a20b"],
          ["Train Yard Level Bomb", "Bubnova Rail", "Kochegarovo", "a20b"],
          ["Train Yard Level Bomb", "Bubnova Rail", "Nevel", "a20b"],
          ["Train Yard Level Bomb", "Bubnova Rail", "Porechye", "a20b"],
          ["Train Yard Level Bomb", "Bubnova Rail", "Drozdova", "a20b"],
          ["Train Yard Level Bomb", "Manistrova Rail Yard", "Kochegarovo", "a20b"],
          ["Train Yard Level Bomb", "Manistrova Rail Yard", "Nevel", "a20b"],
          ["Train Yard Level Bomb", "Manistrova Rail Yard", "Porechye", "a20b"],
          ["Train Yard Level Bomb", "Manistrova Rail Yard", "Drozdova", "a20b"]
        ]
      end
    end
  end
end