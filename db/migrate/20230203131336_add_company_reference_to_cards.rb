class AddCompanyReferenceToCards < ActiveRecord::Migration[7.0]
  def change
    add_reference :cards, :company, null: false, foreign_key: true
  end
end
