class CheatsheetPolicy < ApplicationPolicy
  def show?
    user.purchased_courses.include?(record.course)
  end
end
