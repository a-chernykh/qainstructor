class CreateCheatsheets < ActiveRecord::Migration
  def change
    create_table :cheatsheets do |t|
      t.integer :course_id, null: false
      t.string :code, null: false
    end

    add_foreign_key :cheatsheets, :courses
    add_index :cheatsheets, [:course_id, :code], unique: true
  end
end
