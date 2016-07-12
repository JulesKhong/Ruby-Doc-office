require('spec_helper')

describe(Doctor) do
  describe(".all") do
    it("is empty at first") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe('#save') do
    it('saves doctor to the database') do
      test_doc = Doctor.new({:doctor => "The Doctor", :specialty => "trouble"})
      test_doc.save()
      expect(Doctor.all()).to(eq([test_doc]))
    end
  end

  describe('#==') do
    it("is the same doctor if it has the same doctor and specialty") do
      doctor1 = Doctor.new({:doctor => "Dr. Dolittle", :specialty => "bear hugs"})
      doctor2 = Doctor.new({:doctor => "Dr. Dolittle", :specialty => "bear hugs"})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe('#doctor') do
    it("returns a doctors name") do
      doctor1 = Doctor.new({:doctor => "Dr. Dolittle", :specialty => "bear hugs"})
      expect(doctor1.doctor()).to(eq("Dr. Dolittle"))
    end
  end

  describe('.find_doc_id') do
    it("uses a doctor's name to find and return a doctor's id") do
      doctor1 = Doctor.new({:doctor => "Dr. Dre", :specialty => "layin down rhymes"})
      doctor2 = Doctor.new({:doctor => "Dr. Feelgood", :specialty => "feelin good"})
      doctor1.save()
      doctor2.save()
      expect(Doctor.find_doc_id("Dr. Dre")).to(eq(doctor1.id()))
    end
  end

end
