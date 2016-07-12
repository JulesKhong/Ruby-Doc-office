class Doctor
  attr_reader(:doctor, :specialty)

  define_method(:initialize) do |attributes|
    @doctor = attributes.fetch(:doctor)
    @specialty = attributes.fetch(:specialty)
  end

  define_singleton_method(:all) do
    returned_docs = DB.exec("SELECT * FROM doctor;")
    docs = []
    returned_docs.each() do |doc|
      doctor = doc.fetch("doctor")
      specialty = doc.fetch("specialty")
      docs.push(Doctor.new({:doctor => doctor, :specialty => specialty}))
    end
    docs
  end

  define_method(:save) do
    DB.exec("INSERT INTO doctor (doctor, specialty) VALUES ('#{@doctor}', '#{@specialty}');")
  end

  define_method(:==) do |another_doc|
    self.doctor().==(another_doc.doctor()).&(self.specialty.==(another_doc.specialty()))
  end


end
