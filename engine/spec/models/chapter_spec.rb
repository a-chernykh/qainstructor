RSpec.describe Chapter do
  let(:course) { create(:course, code: 'WEB1') }
  let(:section) { build(:section, code: 'section') }

  subject { build(:chapter, course: course, position: 1, code: 'chapter', section: section) }

  it { is_expected.to define_enum_for(:content_type).with([:text, :exercise]) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:position) }
  it { is_expected.to validate_presence_of(:course_id) }
  it { is_expected.to validate_uniqueness_of(:position).scoped_to :course_id }
  it { is_expected.to validate_presence_of(:section_id) }

  describe '.started_by' do
    let(:user) { create :user }
    let!(:started) { create :chapter }
    let!(:not_started_1) { create :chapter }
    let!(:not_started_2) { create :chapter }

    before do
      create :user_completion, user: user, completable: started
      create :user_completion, completable: not_started_2
    end

    subject { described_class.started_by(user) }

    it { is_expected.to include started }
    it { is_expected.not_to include not_started_1 }
    it { is_expected.not_to include not_started_2 }
  end

  describe '#content_path' do
    it 'returns path to chapter view' do
      expect(subject.content_path).to eq 'web1/section/chapter'
    end
  end

  describe '#previous' do
    let!(:chapter1) { create :chapter, course: course, position: 1 }
    let!(:chapter2) { create :chapter, course: course, position: 2 }
    let!(:chapter3) { create :chapter, course: course, position: 3 }

    context 'for the first chapter in course' do
      it 'returns nil' do
        expect(chapter1.previous).to be_nil
      end
    end

    context 'for the second chapter in course' do
      it 'returns first chapter' do
        expect(chapter2.previous).to eq chapter1
      end
    end

    context 'for the third chapter in course' do
      it 'returns first chapter' do
        expect(chapter3.previous).to eq chapter2
      end
    end
  end

  describe '#next' do
    let!(:chapter3) { create :chapter, course: course, position: 3 }
    let!(:chapter2) { create :chapter, course: course, position: 2 }
    let!(:chapter1) { create :chapter, course: course, position: 1 }

    context 'when next chapter is available' do
      it 'returns it' do
        expect(chapter1.next).to eq chapter2
      end
    end

    context 'when there is no next chapter' do
      it 'returns nil' do
        expect(chapter3.next).to be_nil
      end
    end
  end
end
