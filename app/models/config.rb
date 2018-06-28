class Config < ApplicationRecord
  def self.fetch(key)
    config = Config.find_by_key(key)
    config ? Config.find_by_key(key).value : nil
  end
end
