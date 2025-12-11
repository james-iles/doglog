class CreateShareProfileViewLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :share_profile_view_logs do |t|
      t.references :shareable_profile, null: false, foreign_key: true
      t.datetime :viewed_at, null: false
      t.string :ip_address

      t.timestamps
    end

    add_index :share_profile_view_logs, :viewed_at
  end
end
