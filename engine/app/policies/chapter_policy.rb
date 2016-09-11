class ChapterPolicy < ApplicationPolicy
  def show?
    record.is_demo || user.purchased_courses.include?(record.course)
  end
end
