class Task < ActiveRecord::Base

  scope :tmp_task, -> { where(published_at: nil) }
  scope :actives, -> { where.not(published_at: nil) }

  has_many :task_albums, class_name: 'TaskAlbum', foreign_key: :task_id, dependent: :destroy
  has_many :albums, through: :task_albums
  has_many :comments, as: :commentable

  belongs_to :user, class_name: 'User', foreign_key: :creator_id
  belongs_to :for_user, class_name: 'User', foreign_key: :for_id
end
