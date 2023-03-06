class AddDamagedGamesUserIdToTurns < ActiveRecord::Migration[7.0]
  def change
    add_column :turns, :damaged_games_user_id, :integer
  end
end
