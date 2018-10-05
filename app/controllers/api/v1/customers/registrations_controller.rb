module Api::V1
  class Customers::RegistrationsController < Devise::RegistrationsController
    include Serializable
    include Responsable
    skip_before_action :verify_authenticity_token

    # Sign Up
    def create
      customer = Customer.new(customer_params)
      if customer.save
        customer.acquire_access_token!
        set_response(200,
                     'Ingresado exitosamente',
                     serialize_customer(customer))
      else
        set_response(422, customer.errors.messages.values.join(', '))
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
