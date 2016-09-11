module Api
  module V1

    class JobsController < BaseController
      def create
        job = Services::CreateJob.call(attrs: job_params, user: current_user)
        respond_with(:api, :v1, job)
      end

      def show
        job = Job.where(token: params[:token]).first!
        respond_with(:api, :v1, job)
      end

      private

      def job_params
        params.require(:job).permit(:language,
                                    { files: [:name, :contents] },
                                    meta: [:url])
      end
    end

  end
end
