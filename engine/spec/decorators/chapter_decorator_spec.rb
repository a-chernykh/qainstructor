RSpec.describe ChapterDecorator do
  let(:chapter) { create :chapter }
  let(:user) { create :user }
  let(:engine) { CourseEngine.new(user: user, course: chapter.course) }

  subject { described_class.new(chapter, context: engine) }

  describe '#link' do
    include Rails.application.routes.url_helpers

    context 'when engine is purchased and chapter is not available' do
      it 'returns #' do
        allow(engine).to receive(:purchased?)
          .and_return(true)
        allow(engine).to receive(:chapter_available?)
          .with(chapter)
          .and_return(false)
        expect(subject.link).to eq '#'
      end
    end

    context 'when engine is not purchased and chapter is demo' do
      it 'returns continue url' do
        allow(engine).to receive(:purchased?)
          .and_return(false)
        allow(chapter).to receive(:is_demo)
          .and_return(true)
        allow(engine).to receive(:chapter_available?)
          .with(chapter)
          .and_return(false)

        expect(subject.link).to eq continue_course_path(chapter.course)
      end
    end

    context 'when chapter was started' do
      before { create :user_completion, user: user, completable: chapter }

      it 'returns link to it' do
        expect(subject.link).to eq course_chapter_path(chapter.course, chapter)
      end
    end

    context 'when chapter was not started' do
      it 'returns #' do
        expect(subject.link).to eq course_chapter_path(chapter.course, chapter)
      end
    end
  end

  describe '#tos_link' do
    before { allow(subject).to receive(:link).and_return('chapter link') }

    context 'when chapter is available' do
      it 'returns chapter link' do
        allow(engine).to receive(:chapter_available?)
          .with(chapter)
          .and_return(true)

        expect(subject.tos_link).to eq 'chapter link'
      end
    end

    context 'when chapter is not available' do
      it 'returns #' do
        allow(engine).to receive(:chapter_available?)
          .with(chapter)
          .and_return(false)

        expect(subject.tos_link).to eq '#'
      end
    end
  end
end
