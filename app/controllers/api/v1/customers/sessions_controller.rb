class Api::V1::Customers::SessionsController < Api::V1::ApiController
  include Serializable
  skip_before_action :disable_access_by_tk, only: [:create]
  # skip_before_action :verify_authenticity_token
  before_action :set_customer, only: [:create]

  def create
    if @user && @user.valid_password?(params[:customer][:password])
      if @user.acquire_access_token!
        set_response(:ok, 'Signed In successfully!', serialize_customer(@user))
      else
        # :nocov:
        set_response(:unprocessable_entity, 'Could not get or '\
          'generate  an access token after successful login')
        # :nocov:
      end
    else
      render_unauthorized
    end
  end

  def destroy
    if @user.update_attributes(access_token: nil)
      set_response(:ok, 'Sign out successful')
    else
      # :nocov:
      set_response(:unprocessable_entity, 'Could not release the '\
        'access token after successful logout')
      # :nocov:
    end
  end

  private

  def set_customer
    @user = Customer.find_by_email(params[:customer][:email])
  end
end
