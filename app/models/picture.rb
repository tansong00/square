class Picture < ActiveRecord::Base

  mount_uploader :file, PictureUploader

  belongs_to :album, class_name: 'Album', foreign_key: :album_id

  before_save :save_attr

  private
  def save_attr
    self.file_name = file.file.original_filename
  end
end
