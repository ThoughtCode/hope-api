class CustomerMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Thanks for signing up for our amazing app')
  end

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recupera la contraseña')
  end
end
