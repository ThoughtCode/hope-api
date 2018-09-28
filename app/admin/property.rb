ActiveAdmin.register Property do
  permit_params :customer_id, :name, :neightborhood_id, :p_street, :number, :s_street,
                :additional_reference, :phone

  
  index do
    selectable_column
    id_column
    column :customer
    column :name
    column :p_street
    column :s_street
    column "" do |resource|
      links = ''.html_safe
      links += link_to 'View', resource_path(resource), class: "member_link show_link"
      links += link_to 'Edit', edit_resource_path(resource), class: "member_link edit_link"
      links
    end
  end

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
