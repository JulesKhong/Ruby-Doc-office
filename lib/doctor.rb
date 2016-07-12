class Doctor
  attr_reader(:id, :doctor, :specialty)

  define_method(:initialize) do |attributes|
    @doctor = attributes.fetch(:doctor)
    @specialty = attributes.fetch(:specialty)
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_docs = DB.exec("SELECT * FROM doctor;")
    docs = []
    returned_docs.each() do |doc|
      doctor = doc.fetch("doctor")
      specialty = doc.fetch("specialty")
      id = doc.fetch("id")
      docs.push(Doctor.new({:id => id, :doctor => doctor, :specialty => specialty}))
    end
    docs
  end

  define_method(:save) do
    results = DB.exec("INSERT INTO doctor (doctor, specialty) VALUES ('#{@doctor}', '#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i()
  end

  define_method(:==) do |another_doc|
    self.doctor().==(another_doc.doctor()).&(self.specialty.==(another_doc.specialty()))
  end

  define_singleton_method(:find_doc_id) do |input_doc|
    @doc_id = DB.exec("SELECT id FROM doctor WHERE doctor='#{input_doc}';")
    @doc_id = @doc_id.first['id'].to_i()
  end

  define_singleton_method(:all_doctors) do
    doctors = Doctor.all()
    doctor_names = []
    doctors.each() do |doctor|
      doctor_names.push(doctor.doctor())
    end
    doctor_names
  end
end
