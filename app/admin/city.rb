ActiveAdmin.register City do
  actions :all, :except => :destroy
  permit_params :name, neightborhoods_attributes: [:name, :id, :_destroy ]

  show do
    attributes_table do
      row :name
    end
    panel "Barrios" do
      neightborhoods = City.find(params['id']).neightborhoods
      table_for neightborhoods do
        column :name
      end
    end
  end

  form do |f|
    f.inputs 'Ciudades' do
      f.input :name
      f.has_many :neightborhoods, allow_destroy: true, heading: 'Barrios' , new_record: "Añadir un nuevo barrio" do |nb|
        nb.input :name
      end
    end
    f.actions
  end

end
