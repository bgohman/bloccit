class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :questions
  has_many :comments
  has_many :summaries

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end
end
