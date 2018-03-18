class Api::V1::Agents::SessionsController < Api::V1::ApiController
  skip_before_action :restrict_access_by_token, only: [:create]

  def create
    @current_user = Agent.find_by_email(params[:agent][:email])
    if @current_user && @current_user.valid_password?(params[:agent][:password])
      if @current_user.acquire_access_token!
        render json: @current_user
      else
        render_internal_server_error StandardError.new('Could not get or generate an access token after successful ' \
                                                       'login')
      end
    else
      render_unauthorized
    end
  end

  def destroy
    if @current_user.update_attributes(access_token: nil)
      render_success_message('Sign out successful')
    else
      render_internal_server_error StandardError.new('Could not release the access token after successful logout')
    end
  end
end
