class CustomerMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_welcome_email(user)
    @user = user
    @url = 'https://www.nocnoc.com.ec/'
    mail(to: @user.email,
         subject: 'Gracias por registrarte a nuestra fantastica app')
  end

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recuperar contraseña')
  end

  def send_proposal_received(job, customer, url)
    @url = url + '/cliente/trabajo/' + job.hashed_id
    mail(to: customer.email,
         subject: 'Propuesta de trabajo')
  end

  def send_job_recursivity(job, customer, url)
    @url = url + '/cliente/trabajo/' + job.hashed_id
    @url_cancel = url + '/cliente/trabajo/' + job.hashed_id + '/cancelar'
    mail(to: customer.email,
         subject: 'Trabajo creado automaticamente')
  end

  def send_job_completed(customer, job_id, url)
    @url = url + '/cliente/trabajo/' + job_id.to_s
    mail(to: customer.email,
         subject: 'Trabajo completado exitosamente')
  end

  def send_email_review(job_id, customer, url)
    @url = url + '/cliente/trabajo/' + job_id.to_s
    mail(to: customer.email,
         subject: 'Calificación registrada')
  end

  def send_email_create_job(job, customer, url)
    @url = url + '/cliente/trabajo/' + job.hashed_id.to_s
    @job = job
    service_base = job.job_details.select { |j| j.service.type_service == 'base' }
    @service_base_name = service_base.map { |j| j.service.name }.first
    @service_base_price = service_base.map(&:price_total).first
    @services_addon = job.job_details.select { |j| j.service.type_service == 'addon' }
    @iva = job.job_details.map(&:price_total).sum * 0.12
    @total = job.job_details.map(&:price_total).sum + @iva
    mail(to: customer.email,
         subject: 'Creación de trabajo')
  end
end
