class TaskAlbum < ActiveRecord::Base

  validates :album_id, uniqueness: {scope: :task_id}

  belongs_to :task, class_name: 'Task', foreign_key: :task_id
  belongs_to :album, class_name: 'Album', foreign_key: :album_id


  def parsed_pic_ids
    @pic_ids ||= pic_ids.blank? ? Set.new : Set.new(YAML.load(pic_ids))
  end
end
