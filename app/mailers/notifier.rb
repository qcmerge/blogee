class Notifier < ActionMailer::Base
  default from: "from@example.com"

  def new_comment(user)
    @user = user
    mail(to: user.email, subject: "You got a new comment!")
  end
end
