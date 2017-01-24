class User < ApplicationRecord
  acts_as_authentic

  before_validation :assign_two_factor_secret, on: :create

  def assign_two_factor_secret
    self.two_factor_secret = ROTP::Base32.random_base32
  end

  def confirm_two_factor!
    update_attribute :two_factor_confirmed_at, Time.current
    two_factor_confirmed_at.to_i
  end
end
