class RemoveDefaultValuesFromGames < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :rogue, nil
    change_column_default :games, :wizard, nil
    change_column_default :games, :barbarian, nil
    change_column_default :games, :paladin, nil
  end
end
