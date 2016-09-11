class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit

  private

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || courses_path
  end

  def after_sign_out_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def require_signup!
    unless current_user
      store_location_for(:user, request.original_url)
      redirect_to new_user_registration_path, notice: 'Please sign up to continue'
    end
  end
end
