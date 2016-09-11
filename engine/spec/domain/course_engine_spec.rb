RSpec.describe CourseEngine do
  let(:user) { create :user }
  let(:course) { create :course }
  let!(:chapter2) { create :chapter, course: course, position: 2, is_demo: true }
  let!(:chapter1) { create :chapter, course: course, position: 1 }

  subject { described_class.new(user: user, course: course) }

  describe '#started?' do
    # create completion for another course
    before { create :user_completion, user: user }

    context 'when user has started course' do
      before { create :user_completion, user: user, completable: chapter1 }

      it 'returns true' do
        expect(subject).to be_started
      end
    end

    context 'when user has not started course' do
      it 'returns false' do
        expect(subject).not_to be_started
      end
    end
  end

  describe '#current' do
    it 'returns first demo chapter when user has not purchased the course' do
      expect(subject.current).to eq chapter2
    end

    context 'when user has not started course' do
      it 'returns first chapter' do
        user.purchased_courses << course
        expect(subject.current).to eq chapter1
      end
    end

    context 'when user has finished first chapter' do
      before { create :user_completion, :completed, user: user, completable: chapter1 }

      it 'returns second chapter' do
        expect(subject.current).to eq chapter2
      end
    end

    context 'when user has finished all chapters' do
      before { create :user_completion, :completed, user: user, completable: chapter1 }
      before { create :user_completion, :completed, user: user, completable: chapter2 }

      it 'returns nil' do
        expect(subject.current).to be_nil
      end
    end
  end

  describe '#start_chapter' do
    it 'creates user_completion' do
      subject.start_chapter chapter1
      expect(user.reload.chapters).to include chapter1
    end

    it 'sets started_at' do
      Timecop.freeze do
        subject.start_chapter chapter1
        expect(user.user_completions.where(completable: chapter1).first.started_at.to_i).to eq Time.now.utc.to_i
      end
    end
  end

  describe '#finish_chapter' do
    it 'finishes chapter' do
      subject.finish_chapter chapter1
      expect(user.reload.chapters).to include chapter1
    end

    it 'sets completed_at' do
      Timecop.freeze do
        subject.finish_chapter chapter1
        expect(user.user_completions.where(completable: chapter1).first.completed_at.to_i).to eq Time.now.utc.to_i
      end
    end

    it 'does not set completed_at if previously completed' do
      Timecop.freeze('2010-01-01 00:00:00') do
        subject.finish_chapter chapter1
      end

      Timecop.freeze do
        subject.finish_chapter chapter1
        expect(user.user_completions.where(completable: chapter1).first.completed_at.to_s).to include '2010-01-01'
      end
    end

    it 'starts next chapter' do
      subject.finish_chapter chapter1
      expect(subject.chapter_status(chapter2)).to eq :started
    end

    it 'does not start next chapter if current was a last one' do
      subject.finish_chapter chapter1
      expect(subject).to receive(:start_chapter).once.and_call_original
      subject.finish_chapter chapter2
    end
  end

  describe '#chapter_status' do
    # create user_completion for another course
    before { create :user_completion, user: user }

    context 'when chapter is not started' do
      it 'is not_started' do
        expect(subject.chapter_status(chapter1)).to eq :not_started
      end
    end

    context 'when chapter is started' do
      before { create :user_completion, user: user, completable: chapter1 }

      it 'is started' do
        expect(subject.chapter_status(chapter1)).to eq :started
      end
    end

    context 'when chapter is completed' do
      before { create :user_completion, :completed, user: user, completable: chapter1 }

      it 'is completed' do
        expect(subject.chapter_status(chapter1)).to eq :completed
      end
    end
  end

  describe '#progress' do
    context 'when no chapters were completed' do
      it 'returns 0' do
        expect(subject.progress).to eq 0
      end
    end

    context 'when chapter1 was completed' do
      before { create :user_completion, :completed, user: user, completable: chapter1 }

      it 'returns 50' do
        expect(subject.progress).to eq 50
      end
    end

    context 'when chapter1 and chapter2 were completed' do
      before { create :user_completion, :completed, user: user, completable: chapter1 }
      before { create :user_completion, :completed, user: user, completable: chapter2 }

      it 'returns 100' do
        expect(subject.progress).to eq 100
      end
    end
  end
end
