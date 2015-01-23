require('spec_helper')

describe('Company') do


    describe('#name') do
      it("will return the name of a company") do
        test_company = Company.new({:name => "Hallmark"})
        expect(test_company.name()).to(eq("Hallmark"))
      end
    end

    describe('#id') do
      it("will return the id of a company") do
        test_company = Company.new({:name => "Dealer #1", :id => 1})
        expect(test_company.id()).to(eq(1))
      end
    end

    describe("#save") do
      it("will save the company to the database") do
        test_company = Company.new({:name => "Gap"})
        test_company.save()
        expect(Company.all()).to(eq([test_company]))
      end
    end

    describe(".all") do
      it("will return empty") do
        expect(Company.all()).to(eq([]))
      end
    end

    describe("#==") do
      it("will make sure instances with the same name are equal") do
        test_company1 = Company.new({:name => "Better Dealer"})
        test_company2 = Company.new({:name => "Better Dealer"})
        expect(test_company1).to(eq(test_company2))
      end
    end


end
