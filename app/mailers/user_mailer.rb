class UserMailer < ActionMailer::Base
  default from: "no-reply@movierama.dev"

  def liked(movie)
    @movie = movie
    @user = movie.user
    mail(to: @user.email, subject: "Someone likes your movie!")
  end

  def hated(movie)
    @movie = movie
    @user = movie.user
    mail(to: @user.email, subject: 'Someone hates your movie!')
  end


  private

end
