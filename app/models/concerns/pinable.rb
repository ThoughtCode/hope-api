module Pinable
  extend ActiveSupport::Concern

  def set_reset_password_pin!
    self.mobile_token = six_digit_rand
    save!
  end

  def unset_reset_password_pin!
    self.mobile_token = nil
    save!
  end

  def six_digit_rand
    (SecureRandom.random_number(9e5) + 1e5).to_i
  end
end
