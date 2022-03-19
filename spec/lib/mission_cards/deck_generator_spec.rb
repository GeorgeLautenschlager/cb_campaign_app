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
      expect(subject.actionable_targets('allies')).to match_array ['ground units', 'industrial buildings', 'trains']
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
end