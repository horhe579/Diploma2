class AddDefaultValueToCompanyIdInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :company_id, "593363170"
  end
end
