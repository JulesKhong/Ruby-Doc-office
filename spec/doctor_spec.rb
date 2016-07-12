require('rspec')
require('doctor')
require('pry')
require('pg')

DB = PG.connect({:dbname => "doctors_office_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
  end
end

describe(Doctor) do
  describe(".all") do
    it("is empty at first") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves doctor to the database') do
      test_doc = Doctor.new({:doctor => "The Doctor", :id => nil, :specialty => "trouble"})
      test_doc.save()
      expect(Doctor.all()).to(eq([test_doc]))
    end
  end

  describe('#==') do
    it("is the same doctor if it has the same doctor and specialty") do
      doctor1 = Doctor.new({:doctor => "Dr. Dolittle", :id => nil, :specialty => "bear hugs"})
      doctor2 = Doctor.new({:doctor => "Dr. Dolittle", :id => nil, :specialty => "bear hugs"})
      expect(doctor1).to(eq(doctor2))
    end

  end

end
