class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_params, only: [ :create ]
  skip_before_action :verify_authenticity_token

  # Sign Up
  def create
    user = User.new(user_params)
    if user.save
      render status: 200, json: { message: 'Signed Up successfully!', user: user }
    else
      render json: { message: user.errors }, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def ensure_params
      return if params[:user].present?
      render json: { message: 'Missing params!' }, status: :unprocessable_entity
    end
end
