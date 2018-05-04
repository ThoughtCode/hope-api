module Pinable
  extend ActiveSupport::Concern

  def set_reset_password_pin!
    self.mobile_token = six_digit_rand
    self.mobile_token_expiration = DateTime.current + 6.hours
    save!
  end

  def unset_reset_password_pin!
    self.mobile_token = nil
    save!
  end

  def check_token_expiration_date
    DateTime.current > mobile_token_expiration
  end

  def six_digit_rand
    (SecureRandom.random_number(9e5) + 1e5).to_i
  end
end
