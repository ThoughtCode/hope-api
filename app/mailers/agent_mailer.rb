class AgentMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recuperar contraseña')
  end

  def send_email_to_agent(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Oportunidad de trabajo')
  end

  def job_cancelled_email(agent)
    mail(to: agent.email,
         subject: 'Trabajo cancelado')
  end

  def send_proposal_accepted(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Propuesta de trabajo aceptada')
  end

  def send_job_completed(agent, job_id, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Trabajo completado exitosamente')
  end

  def send_email_review(job_id, agent, url)
    @url = url + '/agente/trabajo/' + job_id.to_s
    mail(to: agent.email,
         subject: 'Calificación recibida')
  end

  def send_welcome_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Bienvenido a la mejor aplicación')
  end
end
