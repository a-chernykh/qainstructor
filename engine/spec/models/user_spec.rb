RSpec.describe User do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }

  describe '#confirmation_required?' do
    it 'does not require confirmation' do
      expect(subject.send(:confirmation_required?)).to be_falsy
    end
  end
end
