class AddGameIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :game_id, :integer
  end
end
