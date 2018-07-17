class ContactMailer < ApplicationMailer
  def contact_mail(params)
    @name = params[:username]
    @cellphone = params[:celular]
    @email = params[:correo]

    managers = Manager.all
    managers.each do |manager|
      mail(to: "jalagut8@gmail.com", subject: "Nuevo contacto")
    end
  end
end
