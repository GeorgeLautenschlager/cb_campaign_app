describe MissionCards::DeckGenerator do
  subject { MissionCards::DeckGenerator.new }

  before do
    MissionCards::DeckGenerator.sync_card_templates!
  end

  let (:raf) do    
    # TODO: fixtures for static data? Probably a shared context is better...
    # TODO: FactoryBot
    Airforce.create(name: 'RAF', coalition: 'allies')
  end

  describe 'loading deck config' do
    it 'specifies the size of the deck' do
      expect(subject.deck_limit).to eq 60
    end

    it 'provides actionable targets' do
      expect(subject.actionable_targets('allies')).to match_array ['ground units', 'industrial buildings']
    end

    it 'provides available planes' do
      expect(subject.available_planes(raf)).to match_array ['p51d15', 'spitfiremkixe', 'a20b']
    end
  end

  describe 'selecting card templates' do
    it 'selects the right card templates' do
      expect(subject.actionable_card_templates(raf).map(&:title)).to match_array [
        "Close Air Support",
        "Factory Strike",
        "Fighter Bomber Attack",
        "Industrial Attack",
        "Industrial Level Bomb"
      ]
    end
  end
end