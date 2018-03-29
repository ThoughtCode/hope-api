class Api::V1::Customers::CustomersController < Api::V1::ApiController
  before_action :set_customer, only: [:update]

  def update
    if @customer
      if @customer.update(customer_params.except(:access_token))
        render json: {
          message: 'Customer have been updated successfully.'
        }
      else
        render json: {
          message: @customer.errors
        }, status: 422
      end
    else
      render json: {
        message: 'Customer not found.'
      }, status: 404
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
