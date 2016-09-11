module Api
  module V1

    RSpec.describe JobsController do
      let(:user) { create(:user) }

      before { login_user(user) }

      describe 'POST create' do
        let(:job_attrs) { attributes_for(:job, language: 'cucumber', meta: { url: 'http://localhost' } ) }

        subject(:action) { post(:create, job: job_attrs, format: :json) }

        before do
          allow_any_instance_of(JobRunner::Cucumber).to receive(:run).and_return true
          allow(JobStatusUpdater).to receive(:perform_async)
        end

        context 'when Job is valid' do
          it 'creates new Job' do
            expect { action }.to change { Job.cucumber.count }.by(1)
          end

          it 'renders serialized Job' do
            action
            expect(json['job']['token']).to eq Job.last.token
          end

          it 'responds with 201 status' do
            action
            expect(response).to have_http_status(:created)
          end
        end

        context 'when Job is invalid' do
          let(:job_attrs) { attributes_for(:job, language: nil) }

          it 'does not create new Job' do
            expect { action }.not_to change { Job.count }
          end

          it 'renders errors' do
            action
            expect(json['errors']).not_to be_empty
          end

          it 'responds with 422 status' do
            action
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe 'GET show' do
        let(:job) { create :job }

        def action
          get :show, token: job.token, format: 'json'
        end

        it 'responds with 200 status' do
          action
          expect(response).to have_http_status(:ok)
        end

        it 'serializes Job' do
          action
          expect(json['job']['status']).to eq 'created'
        end
      end
    end

  end
end
