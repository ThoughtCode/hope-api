module Api::V1::Agents
  class AgentsController < AgentUsersController
    include Serializable
    before_action :set_agent, only: %i[update current_user change_password]
    skip_before_action :disable_access_by_tk, only: [:read_notifications]

    def update
      if @agent
        if @agent.update(agent_params.except(:access_token))
          set_response(200,
                       'Se ha actualizado sastifactoriamente',
                       serialize_agent(@agent))
        else
          set_response(422, @agent.errors.messages.values.join(', '))
        end
      else
        set_response(404, 'Agent not found.')
      end
    end

    def current
      set_response(
        200,
        'Usuario listado exitosamente.',
        serialize_agent(current_user)
      )
    end

    def change_password
      if @agent.valid_password?(params[:agent][:current_password])
        if @agent.update(agent_params)
          AgentMailer.send_reset_password_notification(@agent).deliver
          set_response(
            200,
            'Contraseña actualizada exitosamente',
            serialize_agent(@agent)
          )
        end
      else
        set_response(
          401,
          'La contraseña actual no coincide',
          serialize_agent(current_user)
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
      @agent.mobile_push_token = params[:agent][:mobile_push_token]
      if @agent.save
        set_response(
          200,
          'Mobile Token saved',
          serialize_customer(@agent)
        )
      else
        set_response(422, @agent.errors.messages.values.join(', '))
      end
    end

    private

    def agent_params
      params.require(:agent)
            .permit(:first_name, :last_name, :email, :password,
                    :avatar, :password_confirmation, :national_id, :cell_phone,
                    :birthday)
    end

    def set_agent
      @agent = current_user
    end
  end
end
