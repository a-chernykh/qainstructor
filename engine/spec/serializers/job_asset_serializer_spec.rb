RSpec.describe JobAssetSerializer do
  describe '#attributes' do
    let(:job_asset) { build :job_asset }

    subject { described_class.new(job_asset).attributes }

    it 'includes all attributes' do
      expect(subject.keys).to match_array(%i(name url))
    end
  end
end
