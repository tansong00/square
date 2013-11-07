class Album < ActiveRecord::Base
  mount_uploader :cover, CoverUploader
end
