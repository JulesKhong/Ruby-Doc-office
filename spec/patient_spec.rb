require('spec_helper')

describe(Patient) do
  describe('.all') do
    it("is empty at first") do
      expect(Patient.all()).to(eq([]))
    end
  end
end
