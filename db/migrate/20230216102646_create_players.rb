class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, foreign_key: true
      t.references :company, foreign_key: true

      t.index [:user_id, :game_id], unique: true

      t.timestamps
    end
  end
end
