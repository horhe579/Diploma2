class SetDefaultValuesForDecks < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :rogue, from: nil, to: true
    change_column_default :games, :wizard, from: nil, to: true
    change_column_default :games, :barbarian, from: nil, to: true
    change_column_default :games, :paladin, from: nil, to: true
  end
end
