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

  def send_proposal_received(proposal, customer, url)
    @url = url + '/cliente/propuesta/' + proposal.hashed_id
    mail(to: customer.email,
         subject: 'Propuesta recibida')
  end

  def send_job_recursivity(job, customer, url)
    @url = url + '/cliente/trabajo/' + job.hashed_id
    @url_cancel = url + '/cliente/trabajo/' + job.hashed_id + '/cancelar'
    mail(to: customer.email,
         subject: 'Trabajo creado automaticamente')
  end
end
