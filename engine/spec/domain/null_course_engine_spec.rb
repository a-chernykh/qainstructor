RSpec.describe NullCourseEngine do
  let(:course) { create(:course) }

  subject { described_class.new(course: course) }

  it 'implements the same interface as CourseEngine' do
    CourseEngine.instance_methods(false).each do |method|
      expect(subject).to respond_to(method)
    end
  end

  describe '#progress' do
    it 'returns 0' do
      expect(subject.progress).to eq 0
    end
  end

  describe '#started?' do
    it 'returns false' do
      expect(subject.started?).to eq false
    end
  end

  describe '#chapter_status' do
    it 'returns :not_started' do
      expect(subject.chapter_status('chapter')).to eq :not_started
    end
  end

  describe '#puchased?' do
    it 'returns false' do
      expect(subject.purchased?).to eq false
    end
  end
end
