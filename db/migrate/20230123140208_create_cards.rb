class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
