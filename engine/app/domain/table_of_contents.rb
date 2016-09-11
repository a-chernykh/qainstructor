class TableOfContents
  def initialize(course:, user:, engine:)
    @course = course
    @user = user
    @engine = engine
  end

  def sections
    @course.sections.by_position.map do |section|
      chapters = section.chapters.by_position.includes(:course).decorate(context: @engine)
      OpenStruct.new(section.attributes.merge(chapters: chapters))
    end
  end
end
