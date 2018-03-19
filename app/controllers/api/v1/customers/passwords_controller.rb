class Api::V1::Customers::PasswordsController < Api::V1::ApiController
  skip_before_action :restrict_access_by_token, only: [:create, :update]

  def create
    user = Customer.find_by_email(params[:agent][:email])
    if user
      user.send_reset_password_instructions() 
      render json:  {message: 'Reset password instructions have been sent to email'}
    else
      render json: {message: 'Email does not exist'}, status: 404
    end
  end

  def update
    user = Customer.reset_password_by_token(params)
    if user.errors.empty?
      render json: user
    else
      render json: {message: user.errors}, status: 404
    end
  end
end
