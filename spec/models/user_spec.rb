describe User do
  describe "#create" do
    subject { create :user }
    
    context 'pilots' do
      it 'is assigned an RAF pilot' do
        raf_pilot = subject.raf_pilot

        expect(raf_pilot).to_not be_nil
        expect(raf_pilot.raf?).to eq true
      end

      it 'is assigned a USAAF pilot' do
        usaaf_pilot = subject.usaaf_pilot

        expect(usaaf_pilot).to_not be_nil
        expect(usaaf_pilot.usaaf?).to eq true
      end

      it 'is assigned a Luftwaffe pilot' do
        luftwaffe_pilot = subject.luftwaffe_pilot

        expect(luftwaffe_pilot).to_not be_nil
        expect(luftwaffe_pilot.luftwaffe?).to eq true
      end

      it 'is assigned a VVS pilot' do
        vvs_pilot = subject.vvs_pilot

        expect(vvs_pilot).to_not be_nil
        expect(vvs_pilot.vvs?).to eq true
      end
    end
  end
end