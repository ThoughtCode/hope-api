class Api::V1::Agents::AgentsController < Api::V1::ApiController
  before_action :set_agent, only: [:update]

  def update
    if @agent
      if @agent.update(agent_params.except(:access_token))
        render json: {
          message: 'Agent have been updated successfully.'
        }
      else
        render json: {
          message: @agent.errors
        }, status: 422
      end
    else
      render json: {
        message: 'Agent not found.'
      }, status: 404
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
