class CoursesController < ApplicationController
  before_action :require_signup!, only: %i(continue)
  force_ssl

  helper_method :engine

  def index
    @courses = Course.all
  end

  def continue
    chapter = engine.current
    if chapter
      engine.start_chapter chapter
      redirect_to course_chapter_path(course, chapter)
    else
      redirect_to course_path(course)
    end
  end

  def show
    @course = course.decorate
    @toc = TableOfContents.new(course: @course, user: current_user, engine: engine)
    @order = CourseOrder.new(course: @course, user: current_user)
    store_location_for(:user, course_path(@course))
  end

  def toc
    @course = course.decorate
    @toc = TableOfContents.new(course: @course, user: current_user, engine: engine)
  end

  def engine
    @engine ||= EngineFactory.get(user: current_user, course: course)
  end

  def purchased
    @course = course.decorate
  end

  private

  def course
    @course ||= Course.find params[:id]
  end
end
