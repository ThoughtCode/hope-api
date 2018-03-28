ActiveAdmin.register Agent do
  permit_params :email, :password, :first_name, :last_name, :cell_phone, 
                :birthday, :status, :national_id

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :national_id
    column :email
    column :cell_phone
    column :birthday
    column :status
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :national_id
  filter :cell_phone
  filter :birthday
  filter :status

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Agent Details' do
      f.input :email
      f.input :password
      f.input :first_name
      f.input :last_name
      f.input :national_id
      f.input :cell_phone
      f.input :birthday, start_year: 1960
      f.input :status
    end
    f.actions
  end
end
