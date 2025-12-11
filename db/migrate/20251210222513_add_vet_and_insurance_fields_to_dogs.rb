class AddVetAndInsuranceFieldsToDogs < ActiveRecord::Migration[7.0]
  def change
    add_column :dogs, :vet_name, :string
    add_column :dogs, :vet_clinic, :string
    add_column :dogs, :vet_phone, :string
    add_column :dogs, :vet_address, :text
    add_column :dogs, :insurance_provider, :string
    add_column :dogs, :insurance_policy_number, :string
    add_column :dogs, :microchip_number, :string
    add_column :dogs, :allergies, :text
    add_column :dogs, :medications, :text
    add_column :dogs, :special_notes, :text
  end
end
