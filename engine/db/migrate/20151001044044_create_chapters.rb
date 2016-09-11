class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :course, foreign_key: true, index: true, null: false
      t.integer :position, null: false, default: 0
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :chapters, [:course_id, :position], unique: true
  end
end
