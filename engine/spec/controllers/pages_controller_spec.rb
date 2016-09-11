RSpec.describe PagesController do
  describe 'GET show' do
    it 'renders template for whitelisted page' do
      %w(terms privacy).each do |page|
        get(:show, page: page)
        expect(response).to render_template("pages/#{page}")
      end
    end

    it "won't render unknown page" do
      get(:show, page: 'whatever')
      expect(response).to have_http_status(:not_found)
    end
  end
end
