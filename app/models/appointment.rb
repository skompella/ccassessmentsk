class Appointment < ActiveRecord::Base
  before_save :validate
  def self.import(file)
    CSV.foreach(file.path, :headers => true) do |row|
      Appointment.create! row.to_hash
    end
  end
  def appt_range
    start_time..end_time 
  end
  
  private
  def validate
    @appointments = Appointment.where("start_time is NOT NULL AND end_time is NOT NULL")
      if @appointments.any? {|appt| appt.appt_range.overlaps? appt_range} 
        errors[:base] << "Appointment already exists on this time"
        return false
      end
  end
end
