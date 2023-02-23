class RemoveDefaultFromBackOfCardInCards < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cards, :back_of_card, nil
  end
end
