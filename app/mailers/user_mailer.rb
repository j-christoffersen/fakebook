class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url  = 'https://fakebook-j-christoffersen.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Fakebook')
  end
end
