RSpec.describe JobAssetUploader do
  let(:user) { create(:user) }
  let(:job) { build(:job, user: user, token: 'tok') }
  let(:job_asset) { build(:job_asset, job: job) }

  subject { described_class.new(job_asset) }

  describe '#store_dir' do
    it 'returns dir scoped by user' do
      expect(subject.store_dir).to include("jobs/#{user.id}/tok")
    end
  end
end
