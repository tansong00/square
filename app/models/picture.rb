class Picture < ActiveRecord::Base

  mount_uploader :file, PictureUploader

  belongs_to :album, class_name: 'Album', foreign_key: :album_id

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
        name: read_attribute(:file_name),
        size: size,
        url: file.url,
        delete_url: picture_path(self),
        delete_type: :DELETE
    }
  end

  def size
    file.file.size
  end

  before_save :save_attr

  private
  def save_attr
    self.file_name = file.file.original_filename
  end
end
