module Api::V1
  class Customers::RegistrationsController < Devise::RegistrationsController
    include Serializable
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      customer = Customer.new(customer_params)
      customer.acquire_access_token!
      if customer.save
        set_response(:ok,
                     'Signed Up successfully!',
                     serialize_customer(customer))
      else
        set_response(:unprocessable_entity, customer.errors)
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
