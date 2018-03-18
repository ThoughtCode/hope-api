class Agent < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Public: Assign a new API Token
  def acquire_access_token!
    access_token || generate_access_token
  end

  private

  def generate_access_token
    self.access_token = SecureRandom.hex
    while self.class.exists?(access_token: access_token)
      self.access_token = SecureRandom.hex
    end
    save!
  end
end
