class Post < ActiveRecord::Base
  has_many :comments
  has_many :questions
  belongs_to :user
  belongs_to :topic

# default_scope { order('created_at DESC') }
  scope :ordered_by_title, -> { order('title ASC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
end