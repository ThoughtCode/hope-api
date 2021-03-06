module Api::V1::Agents
  class SessionsController < AgentUsersController
    include Serializable
    skip_before_action :disable_access_by_tk, only: [:create]
    before_action :set_agent, only: [:create]

    def create
      if @user&.valid_password?(params[:agent][:password])
        if @user.acquire_access_token!
          set_response(200, 'Ingreso exitosamente!', serialize_agent(@user))
        else
          # :nocov:
          set_response(422, 'Could not get or '\
            'generate an access token after successful login')
          # :nocov:
        end
      else
        render_unauthorized
      end
    end

    def destroy
      if @user.update_attributes(access_token: nil)
        set_response(200, 'Sign out successful')
      else
        # :nocov:
        set_response(422, 'Could not'\
          'release the access token after successful logout')
        # :nocov:
      end
    end

    private

    def set_agent
      @user = Agent.find_by_email(params[:agent][:email])
    end
  end
end
