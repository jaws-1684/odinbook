class UserMailer < ApplicationMailer
	default from: "book.jawsprojects.net"

 def welcome_email
    @user = params[:user]
    @url  = "https://book.jawsprojects.net/users/sign_in"
    mail(to: @user.email, subject: "Welcome to Odinbook")
  end
end
