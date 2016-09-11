RSpec.describe ApplicationPolicy do
  subject { described_class }

  let(:user) { double('User') }
  let(:record) { double('Record') }

  permissions :index? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :create? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :new? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :update? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :edit? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end

  permissions :destroy? do
    it 'permits' do
      expect(subject).not_to permit(user, record)
    end
  end
end
