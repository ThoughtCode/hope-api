module Hashable
  extend ActiveSupport::Concern

  def generate_hashed_id
    BSON::ObjectId.new.to_s
  end

  included do
    before_create { self.hashed_id = generate_hashed_id }
  end
end
