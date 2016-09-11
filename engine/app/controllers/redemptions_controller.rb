class RedemptionsController < ApplicationController
  before_action :authenticate_user!
  force_ssl

  def new
  end

  def create
    service = Services::RedeemCoupon.new(user: current_user, code: params[:coupon])
    redemption = service.call

    if service.valid?
      redirect_to(course_path(redemption.course), notice: 'Coupon was successfully redeemed')
    else
      @errors = service.errors
      render(:new)
    end
  end
end
