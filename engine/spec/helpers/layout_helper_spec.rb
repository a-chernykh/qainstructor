RSpec.describe LayoutHelper do
  describe '#flash_messages' do
    it 'appends div tag' do
      helper.flash[:error] = 'error'
      allow(helper).to receive(:concat).and_call_original
      expect(helper).to receive(:concat)
        .with('<div class="alert alert-danger fade in"><button class="close" data-dismiss="alert">x</button>error</div>')
        .and_call_original

      helper.flash_messages
    end
  end
end
