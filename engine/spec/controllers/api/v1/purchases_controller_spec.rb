module Api
  module V1

    RSpec.describe PurchasesController do
      let(:course) { create(:course) }
      let(:user) { create(:user) }

      before { login_user(user) }

      describe 'POST create' do
        describe 'success', vcr: { cassette_name: 'Controllers_CoursesController/purchase_success' } do
          let(:action) { post(:create, course_id: course.id,
                                       email: 'andrey@qainstructor.com',
                                       token: 'tok_17QskwGevQFxhd9Er12NBrPs') }

          it 'purchases the course' do
            action
            expect(user.purchased_courses).to include(course)
          end

          it 'returns success json' do
            action
            expect(json['success']).to eq true
          end

          it 'returns 200' do
            action
            expect(response).to have_http_status(:ok)
          end
        end

        describe 'failure', vcr: { cassette_name: 'Controllers_CoursesController/purchase_failure' } do
          let(:action) { post(:create, course_id: course.id,
                                       email: 'andrey@qainstructor.com',
                                       token: 'tok_17QspIGevQFxhd9EqjNr11sf') }

          it 'adds error' do
            action
            expect(json['errors'].length).to eq 1
          end

          it 'returns 422' do
            action
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
