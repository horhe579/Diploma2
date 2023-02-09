class RemoveDefaultUsernameFromUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :username, :string, default: nil
  end
end
