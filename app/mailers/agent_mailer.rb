class AgentMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recupera la contraseña')
  end

  def send_email_to_agent(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Hay un nuevo trabajo disponible')
  end

  def job_cancelled_email(agent)
    mail(to: agent.email,
         subject: 'Han cancelado un trabajo')
  end
  
  def send_proposal_accepted(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Te han aceptado una propuesta para un trabajo')
  end

  def send_job_completed(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Se ha completado un trabajo con exito')
  end

  def send_email_review(job_id, agent, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Te han calificado')
  end

  def send_welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Gracias por registrarte a nuestra fantastica app')
  end
end
