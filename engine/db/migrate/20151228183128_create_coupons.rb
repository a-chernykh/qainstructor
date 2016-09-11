class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code, null: false
      t.integer :course_id, null: false
      t.integer :discount_percent, null: false
      t.integer :redeem_limit, default: 1, null: false

      t.timestamps null: false
    end

    add_index :coupons, :code, unique: true
    add_foreign_key :coupons, :courses
  end
end
