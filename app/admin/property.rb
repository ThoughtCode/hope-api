ActiveAdmin.register Property do
  permit_params :customer_id, :name, :neightborhood_id, :p_street, :number, :s_street, :details,
                :cell_phone
end
