class CourseDecorator < Draper::Decorator
  delegate_all

  def level
    object.level.capitalize
  end

  def time_to_complete
    h.pluralize completion_time_hours, 'hour'
  end
end
