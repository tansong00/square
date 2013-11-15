class CreateTaskAlbums < ActiveRecord::Migration
  def change
    create_table :task_albums do |t|
      t.integer :task_id
      t.integer :album_id
      t.text :pic_ids

      t.timestamps
    end
  end
end
