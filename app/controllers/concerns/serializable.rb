module Serializable
  extend ActiveSupport::Concern

  def serialize_user(user)
    Api::V1::CustomerSerializer.new(user).serialized_json
  end
end
