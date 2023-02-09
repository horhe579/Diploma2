class AddDefaultImageToCards < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cards, :image, "cards/sashostencil.png"
  end
end
