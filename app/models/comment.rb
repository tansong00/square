class Comment < ActiveRecord::Base

  scope :lasts, -> { order('id DESC') }

  belongs_to :commentable, polymorphic: true
end
