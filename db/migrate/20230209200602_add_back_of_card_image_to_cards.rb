class AddBackOfCardImageToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :back_of_card, :string, default: "cards/devil_back.png"
  end
end
