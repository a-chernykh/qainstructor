RSpec.describe JobSerializer do
  describe '#attributes' do
    let(:job) { build :job }

    subject { described_class.new(job).attributes }

    it 'includes all attributes' do
      expect(subject.keys).to match_array(%i(token status result))
    end
  end
end
