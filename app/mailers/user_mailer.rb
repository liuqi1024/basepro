class UserMailer < ActionMailer::Base
  default from: "Base Pro <noreply@basepro.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.invitation.subject
  #
  def invitation user
    @user = user

    mail to: user.email, subject: "welcome to base pro"
  end
end
