module Api::V1::Customers
  class InvoiceDetailsController < CustomerUsersController
    include Serializable
    before_action :set_invoice_details, only: %i[destroy update]
    before_action :invoice_belongs_to_customer?, only: %i[destroy update]

    def index
      invoices = current_user.invoice_details.where(deleted: false)
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

    def update
      if @invoice_details.update(invoice_details_params)
        set_response(200, 'Detalles de facturacion actualizados exitosamente', serialize_invoices(@invoice_details))
      else
        set_response(422, @invoice_details.errors.messages.values.join(', '))
      end
    end

    private

      def invoice_details_params
        params
          .require(:invoice_detail)
          .permit(:email, :identification, :identification_type, :social_reason, :address, :telephone)
      end

      def set_invoice_details
        @invoice_details = InvoiceDetail.find(params[:id])
      end

      def invoice_belongs_to_customer?
        set_response(422, 'No se pudo actualizar la factura porque no te pertenece') if @invoice_details.customer_id != current_user.id
      end
  end
end
