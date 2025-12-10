class AddGenderAndWeightToDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :dogs, :gender, :string
    add_column :dogs, :weight, :decimal
  end
end
