RSpec.describe FormHelper do
  describe '#service_error_messages' do
    it 'adds error message' do
      allow(helper).to receive(:concat)
        .and_call_original
      expect(helper).to receive(:concat)
        .with("<div class=\"alert alert-danger\">err</div>")
        .and_call_original
      helper.service_error_messages(['err'])
    end
  end
end
