module Api
  class BaseController < ApplicationController
    respond_to :json
    before_action :authenticate_user!
  end
end
