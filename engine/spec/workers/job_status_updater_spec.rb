RSpec.describe JobStatusUpdater do
  let(:job) { create(:job) }

  describe '#perform' do
    it 'publishes job status', :vcr do
      expect(Net::HTTP).to receive(:post_form)
        .with(URI.parse('http://faye:8080/faye'), {
          message: {
            channel: "/jobs/#{job.token}",
            data: { status: job.status }
          }.to_json
        })
        .and_call_original
      described_class.perform_async(job.id)
    end
  end
end
