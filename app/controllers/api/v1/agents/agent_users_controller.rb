module Api::V1
  class Agents::AgentUsersController < ApiController
    def disable_access_by_tk
      super
      class_name = @user.class.name
      return set_response(401, 'HTTP Token: Access denied.') if class_name != 'Agent'
    end
  end
end
