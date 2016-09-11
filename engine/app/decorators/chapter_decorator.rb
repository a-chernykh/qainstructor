class ChapterDecorator < Draper::Decorator
  delegate_all

  def link
    engine = context
    if engine.purchased? && !engine.chapter_available?(object)
      '#'
    elsif !engine.purchased? && object.is_demo && !engine.chapter_available?(object)
      h.continue_course_path(object.course)
    else
      h.course_chapter_path(object.course, object)
    end
  end

  def tos_link
    engine = context
    if engine.chapter_available?(object)
      link
    else
      '#'
    end
  end
end
