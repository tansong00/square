class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: true
  validates :password, confirmation: true

  has_many :comments, class_name: 'Comment', foreign_key: :user_id, inverse_of: :user
  has_many :tasks, class_name: 'Task', foreign_key: :creator_id
  has_many :own_tasks, class_name: 'Task', foreign_key: :for_id
  has_many :attachments, class_name: 'Attachment', foreign_key: :user_id

  def root?
    true
  end
end
