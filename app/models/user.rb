class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true, uniqueness: true
  validates :password, confirmation: true

  has_many :comments, class_name: 'Comment', foreign_key: :user_id, dependent: :destroy, inverse_of: :user
end
