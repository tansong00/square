class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :commentable_id
      t.string :commentable_type
      t.text :content

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :commentable_id
  end
end
