RSpec.describe CourseDecorator do
  let(:course) { build :course, level: 'intermediate', completion_time_hours: 5 }

  subject { described_class.new(course) }

  describe '#level' do
    it 'capitalizes level' do
      expect(subject.level).to eq 'Intermediate'
    end
  end

  describe '#time_to_complete' do
    it 'returns 5 hours' do
      expect(subject.time_to_complete).to eq '5 hours'
    end
  end
end
