class NullCourseEngine < CourseEngine
  def initialize(course:)
    @course = course
  end

  def progress
    0
  end

  def started?
    false
  end

  def chapter_status(_)
    :not_started
  end

  def purchased?
    false
  end
end
