class AgentMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recupera la contraseña')
  end

  def send_email_to_agent(agent, job_id, url)
    @url = url + '/cliente/dashboard/trabajos/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Hay un nuevo trabajo disponible')
  end
end
