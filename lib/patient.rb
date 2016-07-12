class Patient
  attr_reader(:name, :birthday, :doctor_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthday = attributes.fetch(:birthday)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patient;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      birthday = patient.fetch('birthday')
      doctor_id = patient.fetch('doctor_id').to_i()
      patients.push(Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id}))
    end
    patients
  end

  define_method(:save) do
    DB.exec("INSERT INTO patient (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id});")
  end

  define_method(:==) do |another_patient|
    self.name().==(another_patient.name()).&(self.birthday.==(another_patient.birthday()))
  end

  define_singleton_method(:find_patients) do |doctor_id|
    patients = DB.exec("SELECT * FROM patient WHERE doctor_id='#{doctor_id}';")
    @patient_names =[]
    patients.each() do |patient|
      name = patient.fetch("name")
      @patient_names.push(name)
    end
    @patient_names
  end
end
