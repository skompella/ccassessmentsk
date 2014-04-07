class Appointment < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, :headers => true) do |row|
      Appointment.create! row.to_hash
    end
  end
end
