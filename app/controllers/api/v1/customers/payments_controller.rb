module Api::V1
  class Customers::PaymentsController < ApiController
    skip_before_action :disable_access_by_tk
    def received
      Rails.logger.info(request.raw_post)
      set_response(
        200, 'OK'
      )
    end
    def update
      Rails.logger.info(request.raw_post)
      set_response(
        200, 'OK'
      )
    end
  end
end
