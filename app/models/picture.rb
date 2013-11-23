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

  def original_filepath
    File.join(File.expand_path('origin', Rails.root), id.to_s, file.file.original_filename)
  end

  before_save :save_attr
  after_destroy :delete_file

  private
  def save_attr
    self.file_name = file.file.original_filename
  end

  def delete_file
    remove_file!
    _path = File.join(File.expand_path('origin', Rails.root), id.to_s)
    FileUtils.rm_rf _path if File.exists? _path
  end
end
