RSpec.describe Coupon do
  subject { create(:coupon) }

  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_uniqueness_of(:code) }
  it { is_expected.to validate_presence_of(:course_id) }
  it { is_expected.to validate_numericality_of(:discount_percent).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(100) }
end
