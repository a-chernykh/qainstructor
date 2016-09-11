module Tasks
  module Courses

    class UnlockChapters
      def initialize(course:, user:)
        @course = course
        @user = user
      end

      def run
        engine = CourseEngine.new(user: @user, course: @course)
        @course.chapters.each { |chapter| engine.finish_chapter(chapter) }
      end
    end

  end
end
