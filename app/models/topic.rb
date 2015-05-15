class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :advertisements, dependent: :destroy

  validates :name, length: { minimum: 5 }, presence: true
  scope :publicly_viewable, -> { where(public: true) }
  scope :privately_viewable, -> { where(public: false) }
  scope :visible_to, -> (user) { user ? all : publicly_viewable }
end

