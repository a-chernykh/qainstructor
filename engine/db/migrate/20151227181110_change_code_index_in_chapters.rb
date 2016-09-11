class ChangeCodeIndexInChapters < ActiveRecord::Migration
  def change
    remove_index :chapters, :code # removes uniquness index
    add_index :chapters, :code
  end
end
