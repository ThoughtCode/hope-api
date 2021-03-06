class CustomerMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'

  def send_welcome_email(user)
    @user = user
    @url = 'https://www.nocnoc.com.ec/'
    mail(to: @user.email,
         subject: 'Gracias por registrarte a nuestra fantástica app')
  end

  def send_recover_password_app_email(user)
    @user = user
    @pin = user.mobile_token
    mail(to: @user.email,
         subject: 'Recuperar contraseña')
  end

  def send_proposal_received(job, customer, url)
    @user = customer
    @url = url + '/cliente/trabajo/' + job.hashed_id
    mail(to: customer.email,
         subject: 'Propuesta de trabajo')
  end

  def send_job_recursivity(job, customer, url)
    @user = customer
    @url = url + '/cliente/trabajo/' + job.hashed_id
    @url_cancel = url + '/cliente/trabajo/' + job.hashed_id + '/cancelar'
    mail(to: customer.email,
         subject: 'Trabajo creado automaticamente')
  end

  def send_job_completed(customer, job_id, url)
    @user = customer
    @url = url + '/cliente/trabajo/' + job_id.to_s
    mail(to: customer.email,
         subject: 'Trabajo completado exitosamente')
  end

  def send_email_review(job_id, customer, url)
    @user = customer
    @url = url + '/cliente/trabajo/' + job_id.to_s
    mail(to: customer.email,
         subject: 'Calificación registrada')
  end

  def send_review_reminder(job_id, customer, url)
    @user = customer
    @url = url + '/cliente/trabajo/' + job_id.to_s
    mail(to: customer.email,
         subject: 'Un trabajo a terminado no olvides calificarlo')
  end

  def send_email_create_job(job, customer, url)
    @url = url + '/cliente/trabajo/' + job.hashed_id.to_s
    @job = job
    @user = customer
    service_base = job.job_details.select { |j| j.service.type_service == 'base' }
    @service_base_name = service_base.map { |j| j.service.name }.first
    @service_base_price = service_base.map(&:price_total).first
    @services_addon = job.job_details.select { |j| j.service.type_service == 'addon' }
    @services_params = job.job_details.select { |j| j.service.type_service == 'parameter' }   
    @overcharge = job.is_holiday?(job.started_at) ? (1 + (Config.fetch('extra_service_fee_holiday').to_f/100)) : 1
    @extra = (((job.job_details.map(&:price_total).sum ) * @overcharge) - job.job_details.map(&:price_total).sum).round(2)
    mail(to: customer.email,
         subject: 'Creación de trabajo')
  end

  def send_receipt_cancelled(job, customer, payment)
    @user = customer
    @job = job
    service_base = job.job_details.select { |j| j.service.type_service == 'base' }
    @service_base_name = service_base.map { |j| j.service.name }.first
    @service_base_price = service_base.map(&:price_total).first
    @services_addon = job.job_details.select { |j| j.service.type_service == 'addon' }
    @services_parameters = job.job_details.select { |j| j.service.type_service == 'parameter' }
    @iva = job.vat.to_f
    @total = job.job_details.map(&:price_total).sum + @iva
    @payment = payment
    mail(to: customer.email,
         subject: 'Nocnoc - Recibo de pago')
  end

  def send_receipt(job, customer, payment)
    @user = customer
    @job = job
    service_base = job.job_details.select { |j| j.service.type_service == 'base' }
    @service_base_name = service_base.map { |j| j.service.name }.first
    @service_base_price = service_base.map(&:price_total).first
    @services_addon = job.job_details.select { |j| j.service.type_service == 'addon' }
    @services_parameters = job.job_details.select { |j| j.service.type_service == 'parameter' }
    @iva = job.vat.to_f
    @total = job.job_details.map(&:price_total).sum + @iva
    @overcharge = job.is_holiday?(job.started_at) ? (1 + (Config.fetch('extra_service_fee_holiday').to_f/100)) : 1
    @extra = (((job.job_details.map(&:price_total).sum ) * @overcharge) - job.job_details.map(&:price_total).sum).round(2)
    @payment = payment
    mail(to: customer.email,
         subject: 'Nocnoc - Recibo de pago')
  end

  def send_reset_password_notification(customer)
    @user = customer
    mail(to: customer.email,
         subject: 'Nocnoc - Tu contraseña ha sido actualizada')
  end
end
