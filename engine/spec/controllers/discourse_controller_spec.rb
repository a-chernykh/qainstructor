RSpec.describe DiscourseController do
  describe 'GET sso' do
    let(:payload) { 'nonce=ABCD' }
    let(:sso) { Base64.encode64(payload) }
    let(:sig) { OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV['DISCOURSE_SSO_SECRET'], sso) }

    let(:action) { get(:sso, sso: sso, sig: sig) }

    it 'requires user to sign in' do
      action
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'with authenticated user' do
      let(:user) { create(:user, email: 'john@doe.com', first_name: 'John', last_name: 'Doe') }

      before { login_user(user) }

      it 'constructs SSO object' do
        action
        sso = assigns[:sso]
        expect(sso.email).to eq 'john@doe.com'
        expect(sso.name).to eq 'John Doe'
        expect(sso.external_id).to eq user.id
        expect(sso.sso_secret).to eq ENV['DISCOURSE_SSO_SECRET']
      end

      it 'redirects user back to discourse' do
        action
        expect(response.redirect_url).to include 'http://forum.qainstructor.com/session/sso_login?sso='
      end
    end
  end
end
