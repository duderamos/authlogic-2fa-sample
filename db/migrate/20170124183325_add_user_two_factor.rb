class AddUserTwoFactor < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :two_factor_secret,        :string
    add_column :users, :two_factor_confirmed_at,  :datetime
  end
end
