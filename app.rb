require('sinatra')
require('sinatra/reloader')
require('./lib/doctor')
require('./lib/patient')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'doctors_office_test'})

get('/') do
  @doctors = Doctor.all_doctors()
  erb(:index)
end

post('/doctor_form') do
  @doctor = params.fetch('doctor')
  @specialty = params.fetch('specialty')
  new_doc = Doctor.new({:doctor => @doctor, :specialty => @specialty})
  new_doc.save()
  erb(:doctor)
end

post('/patient_form') do
  @name = params.fetch('name')
  @birthday = params.fetch('birthday')
  @selected_doc = params.fetch('doctors')
  @doc_id = Doctor.find_doc_id(@selected_doc)
  new_patient = Patient.new({:name => @name, :birthday => @birthday, :doctor_id => @doc_id})
  new_patient.save()
  erb(:patient)
end
