class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :date
      t.string :appointment_type
      t.text :location
      t.text :appointment_notes
      t.string :host
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
