ActiveAdmin.register Manager do
  permit_params :email, :password

  index do
    selectable_column
    id_column
    column :email
    actions
  end

  filter :email

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Manager Details' do
      f.input :email
      f.input :password
    end
    f.actions
  end
end
