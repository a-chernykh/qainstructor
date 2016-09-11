class CreateJobAssets < ActiveRecord::Migration
  def change
    create_table :job_assets do |t|
      t.references :job, null: false
      t.string :file, null: false

      t.timestamps null: false
    end

    add_foreign_key :job_assets, :jobs
  end
end
