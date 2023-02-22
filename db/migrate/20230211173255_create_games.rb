class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.text :players
      t.integer :player_count
      t.boolean :rogue
      t.boolean :wizard
      t.boolean :paladin
      t.boolean :barbarian

      t.timestamps
    end
  end
end
