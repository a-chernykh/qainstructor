class AddMetaToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :meta, :text
  end
end
