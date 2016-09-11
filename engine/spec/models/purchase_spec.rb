RSpec.describe Purchase do
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:course) }
  it { is_expected.to validate_presence_of(:charge_cents) }
  it { is_expected.to validate_numericality_of(:charge_cents) }
end
