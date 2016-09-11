class AddRequirementsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :requirements, :text
  end
end
