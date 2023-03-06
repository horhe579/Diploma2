class AddShieldedGamesUserIdToTurns < ActiveRecord::Migration[7.0]
  def change
    add_column :turns, :shielded_games_user_id, :integer
  end
end
