class AddDefaultValuesToCards < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cards, :damage, 0
    change_column_default :cards, :shield, 0
    change_column_default :cards, :draw, 0
    change_column_default :cards, :play_again, 0
    change_column_default :cards, :heal, 0
  end
end
