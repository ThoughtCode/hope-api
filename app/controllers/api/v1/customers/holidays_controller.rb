module Api::V1::Customers
  class HolidaysController < CustomerUsersController
    include Serializable
    
    def index
      holidays = Holiday.all
      set_response(
        200,
        'Feriados Listados',
        serialize_holiday(holidays)
      )
    end
  end
end
