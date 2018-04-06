module Api::V1
  class Agents::RegistrationsController < Devise::RegistrationsController
    include Serializable
    before_action :ensure_params, only: [:create]
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      agent = Agent.new(agent_params)
      if agent.save
        set_response(:ok, 'Signed Up successfully!', serialize_agent(agent))
      else
        set_response(:unprocessable_entity, agent.errors)
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
      set_response(:unprocessable_entity, 'Missing params!')
    end
  end
end