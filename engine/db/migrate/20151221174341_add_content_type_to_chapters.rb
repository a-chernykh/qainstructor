class AddContentTypeToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :content_type, :integer, null: false, default: 0
  end
end
