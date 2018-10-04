module Api::V1::Customers
  class PasswordsController < CustomerUsersController
    skip_before_action :disable_access_by_tk, only: %i[
      create update app_recover_password app_update_password
    ]
    before_action :set_customer, only: %i[
      create app_recover_password app_update_password
    ]

    def create
      if @customer
        @customer.send_reset_password_instructions
        set_response(200, 'Reset password instructions have been sent to email')
      else
        set_response(404, 'El correo no existe')
      end
    end

    def update
      user = Customer.reset_password_by_token(params)
      if user.errors.empty?
        CustomerMailer.send_reset_password_notification(user).deliver
        set_response(200, 'Reset password successfully')
      else
        set_response(422, user.errors)
      end
    end

    def app_recover_password
      if @customer
        @customer.send_recover_password_email
        set_response(200, 'Un pin ha sido enviado al correo especificado')
      else
        set_response(404, 'El correo no existe')
      end
    end

    def app_update_password
      if @customer
        if !@customer.check_token_expiration_date
          if @customer.update(password_params.except(:mobile_token))
            @customer.unset_reset_password_pin!
            CustomerMailer.send_reset_password_notification(@customer).deliver
            set_response(200, 'Contraseña reseteada exitosamente')
          else
            set_response(404, @customer.errors)
          end
        else
          set_response(401, 'El pin ha expirado')
        end
      else
        set_response(404, 'El correo no existe')
      end
    end

    private

    def set_customer
      @customer = Customer.find_by_email(params[:customer][:email])
    end

    def password_params
      params.require(:customer)
            .permit(:email, :mobile_token, :password, :password_confirmation)
    end
  end
end
