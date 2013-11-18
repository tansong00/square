class TaskAlbum < ActiveRecord::Base

  validates :album_id, uniqueness: {scope: :task_id}

  belongs_to :task, class_name: 'Task', foreign_key: :task_id
  belongs_to :album, class_name: 'Album', foreign_key: :album_id
end
