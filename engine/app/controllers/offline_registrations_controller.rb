class OfflineRegistrationsController < ApplicationController
  layout 'landing'

  def new
    @offline_registration = OfflineRegistration.new
  end

  def create
    @offline_registration = OfflineRegistration.new(offline_registration_params)
    if @offline_registration.save
      redirect_to(thanks_offline_registrations_url)
    else
      render :new
    end
  end

  def thanks
  end

  private

  def offline_registration_params
    params.require(:offline_registration).permit(:name, :phone, :email)
  end
end
