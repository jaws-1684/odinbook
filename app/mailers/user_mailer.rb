class UserMailer < ApplicationMailer
	default from: "onboarding@resend.dev"

 def welcome_email
    @user = params[:user]
    @url  = "https://odinbook-ijrj.onrender.com/users/sign_in"
    mail(to: @user.email, subject: "Welcome to Odinbook")
  end
end
