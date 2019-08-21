class ContactMailer < ApplicationMailer
  default from: 'info@nocnoc.com.ec'
	
  def contact_mail(params)
    @name = params[:name]
    @cellphone = params[:celular]
    @email = params[:email]

    managers = Manager.all
    managers.each do |manager|
      mail(to: manager.email, subject: "Nuevo contacto")
    end
  end
end
