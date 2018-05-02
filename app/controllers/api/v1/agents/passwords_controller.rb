class Api::V1::Agents::PasswordsController < Api::V1::ApiController
  skip_before_action :disable_access_by_tk, only: %i[
    create update app_recover_password app_update_password
  ]
  before_action :set_agent, only: %i[create app_recover_password]

  def create
    if @agent
      @agent.send_reset_password_instructions
      set_response(200, 'Reset password instructions have '\
        'been sent to email')
    else
      set_response(404, 'Email does not exist')
    end
  end

  def update
    user = Agent.reset_password_by_token(params)
    if user.errors.empty?
      set_response(200, 'Reset password successfully')
    else
      set_response(404, user.errors)
    end
  end

  def app_recover_password
    if @agent
      @agent.send_recover_password_email
      set_response(200, 'Un pin ha sido enviado al correo especificado')
    else
      set_response(404, 'El correo no existe')
    end
  end

  def app_update_password
    user = Agent.find_by_mobile_token(password_params.fetch(:mobile_token))
    if user.update(password_params.except(:mobile_token))
      user.unset_reset_password_pin!
      set_response(200, 'Contraseña reseteada exitosamente')
    else
      set_response(404, user.errors)
    end
  end

  private

  def set_agent
    @agent = Agent.find_by_email(params[:agent][:email])
  end

  def password_params
    params.require(:agent)
          .permit(:mobile_token, :password, :password_confirmation)
  end
end
