module Api::V1
  class Agents::RegistrationsController < Devise::RegistrationsController
    include Serializable
    include Responsable
    before_action :ensure_params, only: [:create]
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      agent = Agent.new(agent_params)
      if agent.save
        agent.acquire_access_token!
        set_response(200, 'Signed Up successfully!', serialize_agent(agent))
      else
        set_response(422, agent.errors)
      end
    end

    private

    def agent_params
      params.require(:agent)
            .permit(:first_name, :last_name, :email, :password,
                    :password_confirmation, :national_id, :cell_phone,
                    :birthday, :avatar)
    end

    def ensure_params
      return if params[:agent].present?
      set_response(422, 'Missing params!')
    end
  end
end
