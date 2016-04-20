class VotingMailer < ActionMailer::Base
  default from: "no-reply@movierama.dev"

  def self.voted(type, movie)
    self.send(type, movie)
  end

  def like(movie)
    @movie = movie
    @user = movie.user
    mail(to: @user.email, subject: "Someone likes your movie!")
  end

  def hate(movie)
    @movie = movie
    @user = movie.user
    mail(to: @user.email, subject: 'Someone hates your movie!')
  end


  private

end
