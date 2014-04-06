json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :first_name, :last_name, :start_time, :end_time
  json.url appointment_url(appointment, format: :json)
end
