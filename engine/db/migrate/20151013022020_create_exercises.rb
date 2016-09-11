class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.references :chapter, foreign_key: true, index: true, null: false
      t.integer :position, null: false, default: 0
      t.text :content

      t.timestamps
    end

    add_index :exercises, [:chapter_id, :position], unique: true
  end
end
