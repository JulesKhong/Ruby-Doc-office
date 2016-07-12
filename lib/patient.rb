class Patient
  attr_reader(:name, :birthday)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthday = attributes.fetch(:birthday)
  end

  define_singleton_method(:all) do
    returned_patients = DB.exec("SELECT * FROM patient;")
    patients = []
    returned_patients.each() do |patient|
      name = patients.fetch('name')
      birthday = patients.fetch('birthday')
      patients.push(Patient.new({:name => name, :birthday => birthday}))
    end
    patients
  end
end
