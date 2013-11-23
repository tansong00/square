class BubbleColor4User < ActiveRecord::Migration
  def change
    add_column :users, :bubble_color, :string
  end
end
