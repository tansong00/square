class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :album_id
      t.string :file_name
      t.string :path
      t.string :file
      t.boolean :file_processing

      t.timestamps
    end
  end
end
