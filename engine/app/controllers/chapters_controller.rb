class ChaptersController < ApplicationController
  include AuthorizeCourse

  rescue_from Errors::ChapterIsNotAvailable, with: :chapter_not_available
  before_action :find_chapter

  helper_method :engine

  layout 'chapter'

  def show
    @toc = TableOfContents.new(course: @course, user: current_user, engine: engine)
  end

  def finish
    engine.finish_chapter @chapter
    if @chapter.next
      redirect_to course_chapter_path(@chapter.course, @chapter.next)
    else
      redirect_to @chapter.course
    end
  end

  private

  def engine
    @engine ||= CourseEngine.new(user: current_user, course: @chapter.course)
  end

  def find_chapter
    @chapter = @course.chapters.find(params[:id])
    authorize(@chapter, :show?)

    raise Errors::ChapterIsNotAvailable.new unless @course.chapters
      .started_by(current_user)
      .where(id: params[:id])
      .first
  end

  def chapter_not_available
    redirect_to course_path(@chapter.course),
      flash: { error: 'Chapter is not available. You need to start it first.' }
  end
end
