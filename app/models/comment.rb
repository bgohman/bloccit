class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  default_scope { order('updated_at ASC') }

  after_create :send_favorite_emails

  private

  def send_favorite_emails
    post.favorites.each do |favorite|
      if should_recieve_update_for?(favorite)
        FavoriteMailer.new_comment(favorite.user, post, self).deliver_now
      end
    end
  end

  def should_recieve_update_for?(favorite)
    user_id != favorite.user_id && favorite.user.email_favorites?
  end
end
