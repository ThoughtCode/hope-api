ActiveAdmin.register Property do
  permit_params :customer_id, :name, :neightborhood_id, :p_street, :number, :s_street,
                :additional_reference, :phone

  form do |f|
    f.inputs do
      f.input :customer_id, :label => 'Cliente', as: :select, :collection => Customer.all.map{|u| ["#{u.first_name} #{u.last_name}", u.id]}
      f.input :neightborhood_id, label: 'Barrio', as: :select, collection: Neightborhood.all.map{|b| ["#{b.name}", b.id]}
      f.input :name
      f.input :p_street
      f.input :number
      f.input :s_street
      f.input :additional_reference
      f.input :phone
      f.actions
    end
  end
end
