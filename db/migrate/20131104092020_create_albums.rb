class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.string :sku
      t.string :cover

      t.timestamps
    end
  end
end
