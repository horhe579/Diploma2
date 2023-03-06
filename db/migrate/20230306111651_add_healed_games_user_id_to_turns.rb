class AddHealedGamesUserIdToTurns < ActiveRecord::Migration[7.0]
  def change
    add_column :turns, :healed_games_user_id, :integer
  end
end
