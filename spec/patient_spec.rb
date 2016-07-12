require('spec_helper')

describe(Patient) do
  describe('.all') do
    it("shows the all array as empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a patient to the database') do
      test_patient = Patient.new({:name => "Sam", :birthday => '1999-04-12', :doctor_id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe(':==') do
    it("is the same patient if it has the same name and birthday") do
      patient1 = Patient.new({:name => "Sam", :birthday => "1987-02-15", :doctor_id => 1})
      patient2 = Patient.new({:name => "Sam", :birthday => "1987-02-15", :doctor_id => 1})
      expect(patient1).to(eq(patient2))
    end
  end

  describe('.find_patients') do
    it("it takes the doctor id, and returns the list of patients with that doctor id") do
      patient0 = Patient.new({:name => "Billy", :birthday => "1995-04-12", :doctor_id => 1})
      patient1 = Patient.new({:name => "Skye", :birthday => "1959-02-15", :doctor_id => 2})
      patient2 = Patient.new({:name => "Phil", :birthday => "1970-02-15", :doctor_id => 2})
      patient0.save()
      patient1.save()
      patient2.save()
      expect(Patient.find_patients(1)).to(eq([patient0.name()]))
    end
  end
end
