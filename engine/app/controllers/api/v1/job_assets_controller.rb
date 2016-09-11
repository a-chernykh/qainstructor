module Api
  module V1

    class JobAssetsController < BaseController
      def index
        job = Job.where(token: params[:job_token]).first!
        assets = job.job_assets
        respond_with(:api, :v1, assets)
      end
    end

  end
end
