class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :advertisements, dependent: :destroy

  validates :name, length: { minimum: 5 }, presence: true
  scope :visible_to, -> (user) { user ? all : where(public: true) }
end
