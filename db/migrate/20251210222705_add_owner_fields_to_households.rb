class AddOwnerFieldsToHouseholds < ActiveRecord::Migration[7.0]
  def change
    add_column :households, :owner_name, :string unless column_exists?(:households, :owner_name)
    add_column :households, :email, :string unless column_exists?(:households, :email)
    add_column :households, :phone, :string unless column_exists?(:households, :phone)
  end
end
