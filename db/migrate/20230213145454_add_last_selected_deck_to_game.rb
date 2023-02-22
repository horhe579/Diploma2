class AddLastSelectedDeckToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :last_selected_deck, :string
  end
end
