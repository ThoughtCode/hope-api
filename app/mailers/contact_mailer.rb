class ContactMailer < ApplicationMailer
  def contact_mail(params)
    @name = params[:username]
    @cellphone = params[:celular]
    @email = params[:correo]

    managers = Manager.all
    managers.each do |manager|
      mail(to: manager.email, subject: "Nuevo contacto")
    end
  end
end
