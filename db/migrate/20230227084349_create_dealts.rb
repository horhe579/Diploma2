class CreateDealts < ActiveRecord::Migration[7.0]
  def change
    create_table :dealts do |t|
      t.references :games_user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
