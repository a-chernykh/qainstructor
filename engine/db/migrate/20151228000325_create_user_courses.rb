class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.integer :user_id, null: false
      t.integer :course_id, null: false

      t.timestamps null: false
    end

    add_index :user_courses, [:user_id, :course_id], unique: true
    add_foreign_key :user_courses, :users
    add_foreign_key :user_courses, :courses
  end
end
