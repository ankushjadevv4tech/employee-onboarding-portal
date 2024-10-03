class AddEmployeeFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :department, :string
    add_column :users, :onboarding_status, :string
    add_column :users, :role, :integer
  end
end
