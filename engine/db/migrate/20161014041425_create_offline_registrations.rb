class CreateOfflineRegistrations < ActiveRecord::Migration
  def change
    create_table :offline_registrations do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
