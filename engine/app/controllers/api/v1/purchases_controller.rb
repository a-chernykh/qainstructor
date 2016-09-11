module Api
  module V1

    class PurchasesController < BaseController
      def create
        course = Course.find(params[:course_id])
        service = Services::PurchaseCourse.new(user: current_user,
                                               course: course,
                                               email: params[:email],
                                               token: params[:token])
        service.call
        if service.valid?
          flash[:notice] = 'Thanks for purchasing'
          render json: { success: true }
        else
          render status: :unprocessable_entity, json: { success: false, errors: service.errors }
        end
      end
    end

  end
end
