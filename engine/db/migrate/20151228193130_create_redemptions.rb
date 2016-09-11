class CreateRedemptions < ActiveRecord::Migration
  def change
    create_table :redemptions do |t|
      t.integer :coupon_id, null: false
      t.integer :user_id, null: false
      t.datetime :redeemed_at, null: false
    end

    add_index :redemptions, [:coupon_id, :user_id], unique: true
    add_foreign_key :redemptions, :coupons
    add_foreign_key :redemptions, :users
  end
end
