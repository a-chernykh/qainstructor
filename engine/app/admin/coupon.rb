ActiveAdmin.register Coupon do
  permit_params :course_id, :code, :discount_percent, :redeem_limit, :discount_cents
end
