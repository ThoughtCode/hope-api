class Api::V1::Agents::AgentsController < Api::V1::ApiController
  include Serializable
  before_action :set_agent, only: [:update]

  def update
    if @agent
      if @agent.update(agent_params.except(:access_token))
        set_response(:ok,
                     'Agent have been updated successfully.',
                     serialize_agent(@agent))
      else
        set_response(:unprocessable_entity, @agent.errors)
      end
    else
      set_response(:not_found, 'Agent not found.')
    end
  end

  private

  def agent_params
    params.require(:agent)
          .permit(:access_token, :first_name, :last_name, :email, :password,
                  :password_confirmation, :national_id, :cell_phone, :birthday)
  end

  def set_agent
    @agent = Agent.find_by_access_token(params[:agent][:access_token])
  end
end
