class Api::V1::Customers::CustomersController < Api::V1::ApiController
  include Serializable
  before_action :set_customer, only: %i[update current_user]

  def update
    if @customer.update(customer_params)
      set_response(
        200,
        'Customer have been updated successfully.',
        serialize_customer(@customer)
      )
    else
      set_response(422, @customer.errors)
    end
  end

  def current
    set_response(
      200,
      'Usuario listado exitosamente.',
      serialize_customer(current_user)
    )
  end

  private

  def customer_params
    params.require(:customer)
          .permit(:first_name, :last_name, :email, :password, :avatar,
                  :password_confirmation, :national_id, :cell_phone, :birthday)
  end

  def set_customer
    @customer = current_user
  end
end
