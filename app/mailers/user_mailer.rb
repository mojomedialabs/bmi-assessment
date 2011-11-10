class UserMailer < ActionMailer::Base
  default :from => "sean@teamrgc.com"

  def password_reset(user)
    @user = user

    mail :to => user.email_address, :subject => "Business Model Institute - Password Reset"
  end
end
