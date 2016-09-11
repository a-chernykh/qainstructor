class AddPriceCentsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :price_cents, :integer, default: 0, null: false
  end
end
