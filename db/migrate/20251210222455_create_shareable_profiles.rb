class CreateShareableProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :shareable_profiles do |t|
      t.references :dog, null: false, foreign_key: true
      t.string :token, null: false
      t.string :access_pin_digest
      t.datetime :expires_at
      t.integer :max_views
      t.integer :view_count, default: 0, null: false
      t.text :shared_categories

      t.timestamps
    end

    # Add unique index on token
    add_index :shareable_profiles, :token, unique: true, name: 'unique_token_on_shareable_profiles'
  end
end
