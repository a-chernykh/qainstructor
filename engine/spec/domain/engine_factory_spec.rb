RSpec.describe EngineFactory do
  describe '#get' do
    let(:user) { double('User') }
    let(:course) { double('Course') }

    context 'when user is passed' do
      it 'returns instance of CourseEngine' do
        engine = described_class.get(user: user, course: course)
        expect(engine).to be_an_instance_of(CourseEngine)
      end
    end

    context 'when user is nil' do
      it 'returns instance of NullEngine' do
        engine = described_class.get(user: nil, course: course)
        expect(engine).to be_an_instance_of(NullCourseEngine)
      end
    end
  end
end
