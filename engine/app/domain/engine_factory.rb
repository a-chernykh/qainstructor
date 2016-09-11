class EngineFactory
  def self.get(user:, course:)
    if user
      CourseEngine.new(user: user, course: course)
    else
      NullCourseEngine.new(course: course)
    end
  end
end
