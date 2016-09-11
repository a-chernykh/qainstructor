class AddCodeToChapters < ActiveRecord::Migration
  def up
    add_column :chapters, :code, :string, null: false
    add_index :chapters, :code, unique: true
  end
end
