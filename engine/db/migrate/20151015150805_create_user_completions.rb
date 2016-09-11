class CreateUserCompletions < ActiveRecord::Migration
  def change
    create_table :user_completions do |t|
      t.references :completable, polymorphic: true, index: true, null: false
      t.references :user, null: false

      t.datetime :started_at, null: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :user_completions, [:user_id, :completable_type, :completable_id], unique: true, name: 'index_user_completable_on_user_completions'
    add_foreign_key :user_completions, :users
  end
end
