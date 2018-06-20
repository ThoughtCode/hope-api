module Api::V1
  class Customers::CustomerUsersController < ApiController
    def disable_access_by_tk
      super
      unless @user.blank?
        class_name = @user.class.name
        set_response(401, 'HTTP Token: Access denied.') if class_name != 'Customer'
      end
    end
  end
end
