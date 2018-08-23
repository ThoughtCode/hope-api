ActiveAdmin.register Customer do
  permit_params :email, :password, :first_name, :last_name, :cell_phone,
                :birthday, :national_id, :avatar

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :national_id
    column :email
    column :cell_phone
    column :birthday
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :national_id
  filter :cell_phone
  filter :birthday

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :national_id
      row :email
      row :cell_phone
      row :birthday
      row :avatar
    end
    panel "Propiedades" do
      properties = customer.properties
      table_for properties do
        column :name
        column :neightborhood
        column :p_street
        column :number
        column :s_street
        column :additional_reference
        column :phone
      end
    end
    panel "Tarjetas" do
      cards = customer.credit_cards
      table_for cards do
        column :holder_name
        column :card_type
        column :number
        column :customer_id
        column :token
        column :status
        column :expiry_month
        column :expiry_year
        column 'borrar' do |card|
          link_to 'borrar', delete_card_admin_customers_path(card.id)
        end
      end
    end
    panel "Pagos" do
      payments = customer.payments
      table_for payments do
        column :credit_card
        column :job
        column :amount
        column :description
        column :vat
        column :status
        column :payment_date
        column :installments
        column 'Acciones' do |payment|
          if payment.status == 'Pending'
            link_to 'Procesar Pago', process_payment_admin_customers_path(payment.id)
          elsif payment.status_detail == 'Paid'
            link_to('Reembolsar', refund_admin_payments_path(payment.id))
          else
            'Sin Acción'
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Customer Details' do
      f.input :email
      f.input :password
      f.input :first_name
      f.input :last_name
      f.input :national_id
      f.input :cell_phone
      f.input :birthday, start_year: 1960
      f.input :avatar
    end
    f.actions
  end


  collection_action :delete_card, method: :get do
    cc = CreditCard.find(params[:format])
    if cc.destroy
      flash[:notice] = "Tarjeta Borrada Exitosamente."
      redirect_to admin_customers_path
    else
      flash[:error] = "Error al borrar la tarjeta"
      redirect_to admin_customers_path
    end
  end

  collection_action :process_payment, method: :get do
    payment = Payment.find(params[:format])
    payment.send_payment_request
    flash[:notice] = "El pago ha sido enviado para su procesamiento"
    redirect_to admin_customers_path()
  end

  controller do   
    def update
      if params[:customer][:password].blank? && params[:customer][:password_confirmation].blank?
        params[:customer].delete(:password)
        params[:customer].delete(:password_confirmation)
      end
      super
    end
  end
end
