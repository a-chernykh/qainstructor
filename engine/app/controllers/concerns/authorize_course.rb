module AuthorizeCourse
  extend ActiveSupport::Concern

  included do
    rescue_from Pundit::NotAuthorizedError, with: :course_not_purchased
    before_action :authenticate_user!
    before_action :find_course
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end

  def course_not_purchased
    redirect_to course_path(@course),
      flash: { error: 'You need to purchase this course first' }
  end
end
