class Api::V1::Agents::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params, only: [:create]
  skip_before_action :verify_authenticity_token

  # Sign Up
  def create
    agent = Agent.new(agent_params)
    if agent.save
      render status: 200, json:
        {
          message: 'Signed Up successfully!', agent: agent
        }
    else
      render json: { message: agent.errors }, status: :unprocessable_entity
    end
  end

  private

  def agent_params
    params.require(:agent)
          .permit(:first_name, :last_name, :email, :password,
                  :password_confirmation, :national_id, :cell_phone,
                  :birthday)
  end

  def ensure_params
    return if params[:agent].present?
    render json: { message: 'Missing params!' }, status: :unprocessable_entity
  end
end
