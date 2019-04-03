ActiveAdmin.register Job do
  permit_params :property_id, :started_at, :status, :frequency, :agent_id, :source, job_details_attributes: [:id, :service_id, :value, :_destroy ]

  csv do
    column :id
    column :duration
    column :agent_id
    column "Agente Nombre" do |j|
      j.agent.first_name if j.agent
    end
    column "Agente Apellido" do |j|
      j.agent.last_name if j.agent
    end
    column "Agente Email" do |j|
      j.agent.email if j.agent
    end
    column :hashed_id
    column :started_at do |j|
      j.started_at.localtime
    end
    column :finished_at do |j|
      j.finished_at.localtime
    end
    column :status, default: 0
    column :frequency, default: 0
    column :finished_recurrency_at
    column :card_id
    column :installments
    column :total, precision: 8, scale: 2
    column :vat, precision: 8, scale: 2
    column :service_fee, precision: 8, scale: 2
    column :subtotal, precision: 8, scale: 2
    column :agent_earnings, precision: 8, scale: 2
    column :source

    column :installments do |j|
      j.payment.installments if j.payment
    end

    column :authorization_code do |j|
      j.payment.authorization_code if j.payment
    end

    column :payment_status do |j|
      j.payment.status if j.payment
    end

    column "Payments ID" do |j|
      j.payment_id
    end

    column "Card ID" do |j|
      j.credit_card_id
    end

    column "Card Type" do |j|
      j.credit_card.card_type if j.credit_card 
    end

    column "Card Number" do |j|
      j.credit_card.number if j.credit_card
    end

    column "Card Number" do |j|
      j.credit_card.number if j.credit_card
    end

    column "Cliente Nombre" do |j|
      j.property.customer.full_name if j.property
    end

    column "Cliente Email" do |j|
      j.property.customer.email if j.property
    end

    column "Cliente Direccion" do |j|
      j.property.full_property_name if j.property
    end

    column "Tipo de Servicio" do |j|
      j.job_details.first.service.name
    end
  end

  show do
    attributes_table do
      row :property
      row :started_at do |j|
        j.started_at
      end
      row :finished_at do |j|
        j.finished_at
      end
      row :finished_recurrency_at do |j|
        j.finished_recurrency_at.localtime if j.finished_recurrency_at
      end
      row :duration
      row :status
      row :frequency
      row :details
      row :card
      row :installments
      row :total
      row :vat
      row :service_fee
      row :subtotal
      row :agent_earnings
      row :agent
      row :payment
    end
    panel "Detalles" do
      job_details = Job.find(params['id']).job_details
      table_for job_details do
        column :service
        column :value
        column :price_total
      end
    end
  end

  filter :agent
  filter :property
  filter :duration
  filter :total
  filter :started_at
  filter :finished_at
  filter :status
  filter :frequency

  index do
    selectable_column
    id_column
    column :property
    column :duration
    column :agent
    column :total
    column :status
    column :source
    column :started_at do |j|
      j.started_at.localtime
    end
    column :frequency
    actions
  end

  form do |f|
    f.inputs 'Trabajos' do
      f.input :property
      f.input :started_at
      f.input :status
      f.input :frequency
      f.has_many :job_details, allow_destroy: true, heading: 'Detalles' do |d|
        d.input :service
        d.input :value
      end
      f.input :agent, as: :select, collection: Agent.all.map{|a| ["#{a.first_name} #{a.last_name}" , a.id] }
    end
    f.actions
  end

  controller do
    def update
      @job = Job.find(params[:id])

      super
    end
  end

end
