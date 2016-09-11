class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :token, null: false
      t.integer :language, null: false, default: 0
      t.text :files, null: false
      t.integer :status, null: false, default: 0
      t.integer :result, null: false, default: 0

      t.timestamps
    end
    add_index :jobs, :token, unique: true
  end
end
