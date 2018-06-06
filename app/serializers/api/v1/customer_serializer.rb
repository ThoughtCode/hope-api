class Api::V1::CustomerSerializer
  include FastJsonapi::ObjectSerializer
  set_type :customer # optional
  set_id :id # optional
<<<<<<< Updated upstream
  attributes :first_name, :last_name, :email, :access_token, :avatar
=======
  attributes :first_name, :last_name, :email, :access_token, :avatar,
             :national_id, :cell_phone
>>>>>>> Stashed changes
end
