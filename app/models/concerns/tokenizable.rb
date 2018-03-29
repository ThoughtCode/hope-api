module Tokenizable
  extend ActiveSupport::Concern

  ## Public: Assign a new API Token
  def acquire_access_token!
    access_token || generate_access_token
  end

  def generate_access_token
    while self.class.exists?(access_token: access_token)
      self.access_token = SecureRandom.hex
    end
    save!
  end
end
