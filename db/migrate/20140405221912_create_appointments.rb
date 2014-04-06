class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :start_time
      t.datetime :end_time
      t.text :comments
      t.timestamps
    end
  end
end
