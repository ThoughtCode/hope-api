module Api::V1
  class Customers::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      customer = Customer.new(customer_params)
      if customer.save
        render status: 200, json: {
          message: 'Signed Up successfully!'
        }
      else
        render json: { message: customer.errors }, status: :unprocessable_entity
      end
    end

    private

    def customer_params
      params.require(:customer)
            .permit(:first_name, :last_name, :email, :password,
                    :password_confirmation)
    end
  end
end
