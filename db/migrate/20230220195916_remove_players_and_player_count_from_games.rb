class RemovePlayersAndPlayerCountFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :players, :text
    remove_column :games, :player_count, :integer
  end
end
