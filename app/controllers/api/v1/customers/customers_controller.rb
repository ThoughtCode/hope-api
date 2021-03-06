module Api::V1::Customers
  class CustomersController < CustomerUsersController
    include Serializable
    before_action :set_customer, only: %i[update current_user change_password add_mobile_token]
    skip_before_action :disable_access_by_tk, only: [:read_notifications, :get_user_id]

    def update
      if @customer.update(customer_params)
        set_response(
          200,
          'Datos actualizados exitosamente',
          serialize_customer(@customer)
        )
      else
        set_response(422, @customer.errors.messages.values.join(', '))
      end
    end

    def current
      set_response(
        200,
        'Usuario listado exitosamente.',
        serialize_customer(current_user)
      )
    end

    def change_password
      if @customer.valid_password?(params[:customer][:current_password])
        if @customer.update(customer_params)
          CustomerMailer.send_reset_password_notification(@customer).deliver
          set_response(
            200,
            'Contraseña actualizada exitosamente',
            serialize_customer(@customer)
          )
        end
      else
        set_response(
          401,
          'La contraseña actual no coincide',
          serialize_customer(current_user)
        )
      end
    end

    def get_notifications
      notifications = current_user.notifications.filter_by_status(Notification.statuses[:created]).limit(10)
      set_response(
        200,
        'Notificaciones Enviadas exitosamente',
        serialize_notifications(notifications)
      )
    end

    def read_notifications
      Rails.logger.info('*************************************')
      Rails.logger.info('Read notification')
      Rails.logger.info('*************************************')
      notification = Notification.find(params[:id])
      notification.status = 'opened'
      if notification.save
        set_response(
          200,
          'Se ha recuperado las notificacion con exito',
          serialize_notifications(notification)
        )
      end
    end

    def add_mobile_token
      Rails.logger.info('*************************************')
      Rails.logger.info(params[:customer][:mobile_push_token])
      Rails.logger.info('*************************************')
      if params[:customer][:mobile_push_token]
        Rails.logger.info('*************************************')
        Rails.logger.info('Entra al if')
        Rails.logger.info('*************************************')
        @customer.mobile_push_token = params[:customer][:mobile_push_token]
        if @customer.save
          set_response(
            200,
            'Mobile Token saved',
            serialize_customer(@customer)
          )
        else
          set_response(422, @customer.errors.messages.values.join(', '))
        end
      end
    end

    def get_user_id
      Rails.logger.info(params)
      user = Customer.find_by(email: params[:payment][:email])
      if user
        render json: user.id
      else
        render json: nil
      end
    end

    private

    def customer_params
      params.require(:customer)
            .permit(:first_name, :last_name, :email, :password, :avatar,
                    :password_confirmation, :national_id, :cell_phone, :birthday)
    end

    def set_customer
      @customer = current_user
    end
  end
end
