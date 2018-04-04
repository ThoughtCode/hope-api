class Api::V1::Agents::PasswordsController < Api::V1::ApiController
  skip_before_action :disable_access_by_tk, only: %i[create update]

  def create
    user = Agent.find_by_email(params[:agent][:email])
    if user
      user.send_reset_password_instructions
      set_response(:ok, 'Reset password instructions have '\
        'been sent to email')
    else
      set_response(:not_found, 'Email does not exist')
    end
  end

  def update
    user = Agent.reset_password_by_token(params)
    if user.errors.empty?
      set_response(:ok, 'Reset password successfully')
    else
      set_response(:not_found, user.errors)
    end
  end
end
