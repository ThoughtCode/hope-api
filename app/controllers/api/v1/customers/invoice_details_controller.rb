module Api::V1::Customers
  class InvoiceDetailsController < CustomerUsersController
    include Serializable
    before_action :set_invoice_details, only: %i[destroy]

    def index
      invoices = current_user.invoice_details
      set_response(
        200,
        'Detalles de facturacion listados exitosamente',
        serialize_invoices(invoices)
      )
    end

    def create
      invoice_details = InvoiceDetail.new(invoice_details_params)
      invoice_details.customer = current_user
      if invoice_details.save
        set_response(200, 'Detalles de facturacion creados exitosamente', serialize_invoices(invoice_details))
      else
        set_response(422, invoice_details.errors.messages.values.join(', '))
      end
    end

    def destroy
      @invoice_details.deleted = true
      if @invoice_details.save
        set_response(200, 'Los detalles de facturacion fueron eliminados exitosamente')
      else
        set_response(404, 'Error borrando detalles de facturacion')
      end
    end

    private

    def invoice_details_params
      params
        .require(:invoice_detail)
        .permit(:email, :identification, :identification_type, :social_reason, :address, :telephone)
    end

    def set_invoice_details
      @invoice_details = InvoiceDetail.find_by(id: params[:id])
    end

  end
end
