class CreateTasks < ActiveRecord::Migration
  def up
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.datetime :start_at, :end_at
      t.boolean :complete
      t.integer :user_id
    end
  end

  def down
    drop_table :tasks
  end
end
