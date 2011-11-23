class UserMailer < ActionMailer::Base
  default :from => "sean@teamrgc.com"

  def welcome(user)
    @user = user

    mail :to => user.email_address, :subject => "Welcome to BMI!"
  end

  def password_reset(user)
    @user = user

    mail :to => user.email_address, :subject => "Business Model Institute - Password Reset"
  end

  def assessment_results(assessment, user)
    @assessment = assessment
    @user = user

    mail :to => user.email_address, :subject => "Your BMI Assessment results are here!"
  end

  def admin_assessment_results(assessment, user)
    @assessment = assessment
    @user = user

    mail :to => User.admins.map(&:email_address), :subject => "BMI Assessment results are in for #{@user.first_name} #{@user.last_name}!"
  end
end
