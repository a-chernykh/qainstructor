class AddIsDemoToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :is_demo, :boolean, default: false
  end
end
