RSpec.describe Api::V1::JobAssetsController do
  let(:user) { create(:user) }

  describe 'GET index' do
    def action
      get :index, job_token: job.token, format: 'json'
    end

    let(:job) { create :job }
    let!(:file1) { create :job_asset, job: job, file: File.open(Rails.root.join('spec/fixtures/output.html')) }

    before { login_user(user) }

    it 'responds with 200 status' do
      action
      expect(response).to have_http_status(:ok)
    end

    it 'serializes list of job assets' do
      action
      expect(json['job_assets'][0]['name']).to eq 'output.html'
      expect(json['job_assets'][0]['url']).to include 'output.html'
    end
  end
end
