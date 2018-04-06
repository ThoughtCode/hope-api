class Api::V1::Customers::CustomersController < Api::V1::ApiController
  include Serializable
  before_action :set_customer, only: [:update]

  def update
    if @customer
      if @customer.update(customer_params.except(:access_token))
        set_response(:ok,
                     'Customer have been updated successfully.',
                     serialize_customer(@customer))
      else
        set_response(:unprocessable_entity, @customer.errors)
      end
    else
      set_response(:not_found, 'Customer not found.')
    end
  end

  private

  def customer_params
    params.require(:customer)
          .permit(:access_token, :first_name, :last_name, :email, :password,
                  :password_confirmation, :national_id, :cell_phone, :birthday)
  end

  def set_customer
    @customer = Customer.find_by_access_token(params[:customer][:access_token])
  end
end
