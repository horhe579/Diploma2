class SetDefaultHpAndShieldInGamesUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games_users, :hp, 10
    change_column_default :games_users, :shield, 0
  end
end
