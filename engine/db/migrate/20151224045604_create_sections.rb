class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :course, null: false
      t.string :code, null: false
      t.string :name, null: false
      t.integer :position, null: false
      t.text :description

      t.timestamps null: false
    end

    add_foreign_key :sections, :courses
    add_index :sections, [:course_id, :position], unique: true
    add_index :sections, [:course_id, :code], unique: true
  end
end
