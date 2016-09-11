class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code, null: false, unique: true
      t.string :name, null: false
      t.integer :level, default: 0, null: false
      t.integer :completion_time_hours, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
