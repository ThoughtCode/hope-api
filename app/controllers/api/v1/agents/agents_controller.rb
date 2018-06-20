module Api::V1::Agents
  class AgentsController < AgentController
    include Serializable
    before_action :set_agent, only: [:update]

    def update
      if @agent
        if @agent.update(agent_params.except(:access_token))
          set_response(200,
                       'Agent have been updated successfully.',
                       serialize_agent(@agent))
        else
          set_response(422, @agent.errors)
        end
      else
        set_response(404, 'Agent not found.')
      end
    end

    def change_password
      if @agent.valid_password?(params[:agent][:current_password])
        if @agent.update(agent_params)
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

    private

    def agent_params
      params.require(:agent)
            .permit(:access_token, :first_name, :last_name, :email, :password,
                    :avatar, :password_confirmation, :national_id, :cell_phone,
                    :birthday)
    end

    def set_agent
      @agent = Agent.find_by_access_token(params[:agent][:access_token])
    end
  end
end
