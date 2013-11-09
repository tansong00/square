class Album < ActiveRecord::Base
  mount_uploader :cover, CoverUploader

  has_many :pictures, class_name: 'Picture', foreign_key: :album_id, dependent: :destroy
end
