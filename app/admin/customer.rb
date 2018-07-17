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
