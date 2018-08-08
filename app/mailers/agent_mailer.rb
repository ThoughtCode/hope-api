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
    text = 'Hay un nuevo trabajo disponible'
    mail(to: agent.email,
         subject: text)
    Notification.create(info: text, agent: agent, job_id: job_id)
  end

  def job_cancelled_email(agent)
    text = 'Han cancelado un trabajo'
    mail(to: agent.email,
         subject: text)
    Notification.create(info: text, agent: agent)
  end

  def send_proposal_accepted(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    text = 'Te han aceptado una propuesta para un trabajo'
    mail(to: agent.email,
         subject: text)
    Notification.create(info: text, agent: agent, job_id: job_id)
  end

  def send_job_completed(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Se ha completado un trabajo con exito')
  end

  def send_email_review(job_id, agent, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    text = 'Te han calificado'
    mail(to: agent.email,
         subject: text)
    Notification.create(info: text, agent: agent, job_id: job_id)
  end

  def send_welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Gracias por registrarte a nuestra fantastica app')
  end
end
