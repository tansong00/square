class Attachment < ActiveRecord::Base

  mount_uploader :file, AttachmentUploader

  scope :lasts, -> { order('id DESC') }

  validates :file, presence: true

  belongs_to :attachmentable, polymorphic: true
  belongs_to :user, class_name: 'User', foreign_key: :user_id

  after_destroy :delete_file

  def delete_file
    remove_file!
  end
end