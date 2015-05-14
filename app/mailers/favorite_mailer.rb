class FavoriteMailer < ActionMailer::Base
  default from: "bradley.s.gohman@gmail.com"

  def new_comment(user, post, comment)

    #New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@bgohman-bloccit.herokuapp.com"
    headers["In-Reply_To"] = "<post/#{post.id}@bgohman-bloccit.herokuapp.com"
    headers["References"] = "<post/#{post.id}@bgohman-bloccit.herokuapp.com"

    @user = user
    @post = post
    @comment = comment

    mail(to:user.email, subject: "New comment on #{post.title}")
  end
end


