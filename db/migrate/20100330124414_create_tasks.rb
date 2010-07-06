class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.references :user
      t.references :project
      t.datetime :closed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
