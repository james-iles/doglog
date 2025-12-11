class ImproveAppointmentsTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :appointments, :date, :datetime

    add_column :appointments, :start_time, :datetime, null: false
    add_column :appointments, :end_time, :datetime, null: false

  end
end
