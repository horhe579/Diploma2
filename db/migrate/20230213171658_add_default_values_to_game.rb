class AddDefaultValuesToGame < ActiveRecord::Migration[7.0]
  def change
    change_column_default :games, :rogue, true
    change_column_default :games, :wizard, true
    change_column_default :games, :paladin, true
    change_column_default :games, :barbarian, true
  end
end
