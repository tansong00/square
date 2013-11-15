class Task < ActiveRecord::Base

  has_many :task_albums, class_name: 'TaskAlbum', foreign_key: :task_id, dependent: :destroy
  has_many :albums, through: :task_albums
end
