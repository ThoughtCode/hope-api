class AgentMailer < ApplicationMailer
  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recupera la contraseña')
  end
end
