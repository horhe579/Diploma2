class AddHealToCards < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :heal, :integer
  end
end
