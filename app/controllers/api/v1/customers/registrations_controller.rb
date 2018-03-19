module Api::V1
  class Customers::RegistrationsController < Devise::RegistrationsController
    before_action :ensure_params, only: [:create]
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      customer = Customer.new(customer_params)
      if customer.save
        render status: 200, json: {
          message: 'Signed Up successfully!', customer: customer
        }
      else
        render json: { message: customer.errors }, status: :unprocessable_entity
      end
    end

    private

    def customer_params
      params.require(:customer)
            .permit(:email, :password, :password_confirmation)
    end

    def ensure_params
      return if params[:customer].present?
      render json: { message: 'Missing params!' }, status: :unprocessable_entity
    end
  end
end
