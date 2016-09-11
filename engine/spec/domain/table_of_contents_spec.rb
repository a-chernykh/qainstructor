RSpec.describe TableOfContents do
  let(:user) { create(:user) }
  let(:course) { create(:course) }
  let(:engine) { CourseEngine.new(user: user, course: course) }
  let!(:section2) { create(:section, course: course, position: 2, name: 'Section 2') }
  let!(:section1) { create(:section, course: course, position: 1, name: 'Section 1') }
  let!(:chapter1) { create(:chapter, section: section1, course: course, position: 1) }
  let!(:chapter2) { create(:chapter, section: section1, course: course, position: 2) }
  let!(:chapter3) { create(:chapter, section: section2, course: course, position: 3) }

  subject { described_class.new(course: course, user: user, engine: engine) }

  describe '#sections' do
    it 'returns sections' do
      sections = subject.sections
      expect(sections.map(&:name)).to eq ['Section 1', 'Section 2']
    end

    it 'adds chapters' do
      section1 = subject.sections.first
      expect(section1.chapters).to eq [chapter1, chapter2]
    end

    it 'decorates chapters' do
      section1 = subject.sections.first
      chapter1 = section1.chapters.first
      expect(chapter1).to respond_to(:link)
    end
  end
end
