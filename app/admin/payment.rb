ActiveAdmin.register Payment do
  actions :all, :except => :destroy

  index do
    selectable_column
    id_column
    column :job
    column :amount
    column :description
    column :payment_date
    column :status
    column :status_detail
    actions
  end

  show do
    attributes_table do
      row :job
      row :credit_card
      row :amount
      row :description
      row :vat
      row :payment_date
      row :authorization_code
      row :installments
      row :message
      row :carrier_code
      row :status_detail
      row :customer
      row :status
      row :transaction_identifier
      row :refund do |p|
        if p.status == 'Approved'
          link_to('Reembolsar', refund_admin_payments_path(p.id))
        elsif p.status == 'Pending' 
          link_to 'Procesar Pago', process_payment_admin_customers_path(payment.id)
        else
          ''
        end
      end
    end
  end

  collection_action :refund, method: :get do
    payment = Payment.find(params[:format])
    payment.refund
    flash[:notice] = "Se ha iniciado el proceso de reembolso"
    redirect_to admin_payments_path()
  end
end
