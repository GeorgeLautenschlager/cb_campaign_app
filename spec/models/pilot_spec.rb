describe Pilot do
  describe "create" do
    context "RAF" do
      subject { create :raf_pilot }

      it 'creates the pilot and populates names' do
        expect(subject).to be_valid

        expect(subject.first_name).to be_present
        expect(subject.last_name).to be_present
      end
    end

    context "USAAF" do
      subject { create :usaaf_pilot }

      it 'creates the pilot and populates names' do
        expect(subject).to be_valid

        expect(subject.first_name).to be_present
        expect(subject.last_name).to be_present
      end
    end

    context "VVS" do
      subject { create :vvs_pilot }

      it 'creates the pilot and populates names' do
        expect(subject).to be_valid

        expect(subject.first_name).to be_present
        expect(subject.last_name).to be_present
      end
    end

    context "Luftwaffe" do
      subject { create :luftwaffe_pilot }

      it 'creates the pilot and populates names' do
        expect(subject).to be_valid

        expect(subject.first_name).to be_present
        expect(subject.last_name).to be_present
      end
    end
  end
end