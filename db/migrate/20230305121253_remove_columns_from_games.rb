class RemoveColumnsFromGames < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :rogue, :boolean
    remove_column :games, :wizard, :boolean
    remove_column :games, :paladin, :boolean
    remove_column :games, :barbarian, :boolean
    remove_column :games, :last_selected_deck, :text
  end
end
