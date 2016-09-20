class AddDiscountCentsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :discount_cents, :integer, default: 0
  end
end
