class AddSectionIdToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :section_id, :integer, null: false
    add_index :chapters, :section_id
  end
end
