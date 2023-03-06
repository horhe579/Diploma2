class AddCompletedAtToGamesUser < ActiveRecord::Migration[7.0]
  def change
    add_column :games_users, :completed_at, :datetime
  end
end
