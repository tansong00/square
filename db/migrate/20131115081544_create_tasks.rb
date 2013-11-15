class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :for_id
      t.integer :creator_id
      t.datetime :closed_at
      t.datetime :published_at
      t.text :desc

      t.timestamps
    end
  end
end
