RSpec.shared_context "app config", :shared_context => :metadata do
  let!(:raf) { create :airforce, :raf }
  let!(:usaaf) { create :airforce, :usaaf }
  let!(:vvs) { create :airforce, :vvs }
  let!(:luftwaffe) { create :airforce, :luftwaffe }

  before do
    MissionCards::DeckGenerator.sync_card_templates!
  end
end
