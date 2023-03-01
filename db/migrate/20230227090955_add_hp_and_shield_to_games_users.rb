class AddHpAndShieldToGamesUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :games_users, :hp, :integer
    add_column :games_users, :shield, :integer
  end
end
