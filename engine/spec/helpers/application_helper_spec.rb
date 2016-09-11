RSpec.describe ApplicationHelper do
  describe '#example_output_path' do
    it 'returns path to course example' do
      course = double('Course', code: 'course-code')
      chapter = double('Chapter', course: course)
      path = helper.example_output_path(chapter: chapter, example: 1)
      expect(path).to eq '/output/course-code/course-code-example1.html'
    end
  end

  describe '#sample_app_url' do
    it 'returns subdomain url' do
      url = helper.sample_app_url('test')
      expect(url).to eq 'http://test.sample.lvh.me'
    end
  end

  describe '#price_in_dollars' do
    it 'returns 39 for 3900' do
      expect(helper.price_in_dollars(3900)).to eq 39
    end

    it 'returns 39.5 for 3950' do
      expect(helper.price_in_dollars(3950)).to eq 39.5
    end
  end
end
