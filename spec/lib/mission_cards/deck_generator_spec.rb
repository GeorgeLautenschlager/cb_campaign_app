describe MissionCards::DeckGenerator do
  subject { MissionCards::DeckGenerator.new }

  it 'Prints a pithy message' do
    expect(subject.generate!).to eq "I'll do it this afternoon!"
  end
end