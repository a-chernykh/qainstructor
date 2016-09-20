class ChangeDiscountPercentDefaultInCoupons < ActiveRecord::Migration
  def up
    change_column_default :coupons, :discount_percent, 0
  end

  def down
    change_column_default :coupons, :discount_percent, nil
  end
end
