class Api::V1::Agents::SessionsController < Api::V1::ApiController
  skip_before_action :disable_access_by_tk, only: [:create]
  before_action :set_agent, only: [:create]

  def create
    if @user && @user.valid_password?(params[:agent][:password])
      if @user.acquire_access_token!
        json_agent = Api::V1::AgentSerializer.new(@user).serialized_json
        render json: json_agent
      else
        render_internal_server_error StandardError.new('Could not get or '\
          'generate an access token after successful login')
      end
    else
      render_unauthorized
    end
  end

  def destroy
    if @user.update_attributes(access_token: nil)
      render_success_message('Sign out successful')
    else
      render_internal_server_error StandardError.new('Could not'\
        'release the access token after successful logout')
    end
  end

  private

  def set_agent
    @user = Agent.find_by_email(params[:agent][:email])
  end
end
