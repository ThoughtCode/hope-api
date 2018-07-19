class PasswordMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def reset_password_instructions(user, token, _params)
    byebug
    @user = user
    @url = ENV['FRONTEND_URL'] + '/resetear/' + token if user.class.name == 'Customer'
    @url = ENV['FRONTEND_URL'] + '/agente/resetear/' + token if user.class.name == 'Agent'
    mail(to: @user.email,
         subject: 'Cambio de clave')
  end
end
