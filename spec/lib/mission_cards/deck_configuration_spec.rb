describe MissionCards::DeckConfiguration do
  include_context "app config"

  subject { MissionCards::DeckConfiguration.new }

  describe "allied_objectives" do
    it "should select only allied objectives" do
      expect(subject.allied_objectives.map(&:Name)).to match_array [
        "Nevel Railyard", "Novo Railyard", "Nasva Railyard",
        "Kuchina Rail Depot", "Markiznova Rail Depot", "Berezovka Armored Div"
      ]
    end
  end

  describe "axis_objectives" do
    it "should select only allied objectives" do
      expect(subject.axis_objectives.map(&:Name)).to match_array ["Veliki Rail Terminal",
        "Sopki Railyard", "Losevo Grain", "Toropets Rail", "Rojnova Bridges",
        "Kamenka Defenses", "Bubnova Rail", "Manistrova Rail Yard",
        "Philiptsevo Armored D", "Zaluchie Shipping"
      ]
    end
  end

  describe "allied_targets" do
    it "maps target_types to areas of operations" do
      expected_targets = {
        "bases" => [
          "Veliki Rail Terminal", "Sopki Railyard", "Toropets Rail",
          "Rojnova Bridges", "Kamenka Defenses", "Bubnova Rail",
          "Manistrova Rail Yard", "Philiptsevo Armored D", "Zaluchie Shipping"
        ],
        "industrial buildings" => [
          "Veliki Rail Terminal", "Sopki Railyard", "Toropets Rail",
          "Bubnova Rail", "Manistrova Rail Yard"
        ],
        "trains" => [
          "Veliki Rail Terminal", "Sopki Railyard", "Toropets Rail",
          "Bubnova Rail", "Manistrova Rail Yard"
        ],
        "ground units" => [
          "Veliki Rail Terminal", "Rojnova Bridges", "Kamenka Defenses",
          "Bubnova Rail", "Manistrova Rail Yard", "Philiptsevo Armored D", 
          "Zaluchie Shipping"
        ],
        "bridges" => ["Rojnova Bridges"],
        "tanks" => [
          "Rojnova Bridges", "Kamenka Defenses", "Bubnova Rail",
          "Manistrova Rail Yard", "Philiptsevo Armored D"
        ],
        "coastal logistics"=>["Zaluchie Shipping"]
      }

      expect(subject.allied_targets).to eq expected_targets
    end
  end

  describe "axis_targets" do
    it "maps target_types to areas of operations" do
      expected_targets = {
        "trains"=>["Nevel Railyard", "Novo Railyard", "Markiznova Rail Depot"],
        "industrial buildings"=>["Nevel Railyard", "Novo Railyard", "Nasva Railyard", "Kuchina Rail Depot", "Markiznova Rail Depot"],
        "bases"=>["Nevel Railyard", "Novo Railyard", "Kuchina Rail Depot", "Markiznova Rail Depot", "Berezovka Armored Div"],
        "ground units"=>["Novo Railyard", "Kuchina Rail Depot", "Markiznova Rail Depot", "Berezovka Armored Div"],
        "tanks"=>["Kuchina Rail Depot", "Berezovka Armored Div"],
        "bridges"=>["Kuchina Rail Depot"]
      }

      expect(subject.axis_targets).to eq expected_targets
    end
  end

  describe "allied_airframes" do
    context "maps airframe names to airfields where they are available" do
      it "for the RAF" do
        expected_targets = {
          "a20b"=>["Nasva", "Zabel Ye", "Novo"],
          "p51b5"=>["Nasva", "Zabel Ye", "Novo"],
          "typhoonmkib"=>["Nasva", "Zabel Ye", "Novo"],
          "spitfiremkixe"=>["Nasva", "Zabel Ye", "Novo"],
          "p47d22"=>["Zabel Ye"],
        }
        
        expect(subject.allied_airframes[:raf]).to eq expected_targets
      end

      it "for the USAAF" do
        expected_targets = {
          "a20b"=>["Kochegarovo", "Nevel", "Porechye", "Drozdova"],
          "p38j25" => ["Nevel", "Drozdova"],
          "p51b5"=>["Kochegarovo", "Nevel", "Porechye", "Drozdova"],
          "p47d22"=>["Nevel", "Drozdova"],
        }
        
        expect(subject.allied_airframes[:usaaf]).to eq expected_targets
      end
    end
  end
end