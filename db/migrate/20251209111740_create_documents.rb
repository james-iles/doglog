class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :category
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
