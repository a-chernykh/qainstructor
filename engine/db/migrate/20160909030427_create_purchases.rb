class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false
      t.integer :charge_cents, null: false

      t.timestamps
    end

    add_foreign_key :purchases, :users
    add_foreign_key :purchases, :courses
  end
end
