class Api::V1::HolidaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :holiday_date
end
