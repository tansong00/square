class Comment < ActiveRecord::Base

  scope :lasts, -> { order('id DESC') }

  belongs_to :commentable, polymorphic: true
  belongs_to :user, class_name: 'User', foreign_key: :user_id


  def resource
    klass = commentable_type.capitalize.constantize
    @resource ||= klass.find commentable_id
  end
end
