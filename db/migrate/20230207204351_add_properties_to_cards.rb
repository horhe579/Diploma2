class AddPropertiesToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :damage, :integer
    add_column :cards, :shield, :integer
    add_column :cards, :draw, :integer
    add_column :cards, :play_again, :integer
  end
end
