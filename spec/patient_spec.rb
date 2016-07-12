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
end
