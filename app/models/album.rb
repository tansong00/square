class Album < ActiveRecord::Base
  resourcify

  mount_uploader :cover, CoverUploader

  scope :lasts, -> { order('id DESC') }

  validates :sku, uniqueness: true

  has_many :pictures, class_name: 'Picture', foreign_key: :album_id, dependent: :destroy
  has_many :task_albums, class_name: 'TaskAlbum', foreign_key: :album_id, dependent: :destroy
  has_many :tasks, through: :task_albums

  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable
end
