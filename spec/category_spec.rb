require('spec_helper')


describe('Category') do

  describe('#name') do
    it("will return the name of a category") do
      test_category = Category.new({:name => "gifts"})
      expect(test_category.name()).to(eq("gifts"))
    end
  end

  describe('#id') do
    it("will return the id of a category") do
      test_category = Category.new({:name => "illicit drugs", :id => 1})
      expect(test_category.id()).to(eq(1))
    end
  end

  describe("#save") do
    it("will save the category to the database") do
      test_category = Category.new({:name => "clothes"})
      test_category.save()
      expect(Category.all()).to(eq([test_category]))
    end
  end

  describe(".all") do
    it("will return empty") do
      expect(Category.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("will make sure instances with the same name are equal") do
      test_category1 = Category.new({:name => "street drugs"})
      test_category2 = Category.new({:name => "street drugs"})
      expect(test_category1).to(eq(test_category2))
    end
  end

  describe("#budget_status") do
    it("will check if a category is over budget") do
      test_category = Category.new({:name => "drugs", :budget => 350})
      test_category.save()
      test_expense = Expense.new({:description => "crackrock", :amount => 500, :date => "2015-01-21"})
      test_expense.save()
      test_expense.add_category(test_category)
      expect(test_category.budget_status()).to(eq("You are over budget."))
    end
  end

  describe("#company_percentage") do
    it("will return how many percent of the category expenses was used in a desired company") do
      test_category = Category.new({:name => "Food"})
      test_category.save()

      test_expense = Expense.new({:description => "Burger", :amount => 100.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category)
      test_company = Company.new({:name => "McDs"})
      test_company.save()
      test_expense.add_company(test_company)

      test_expense = Expense.new({:description => "Burger", :amount => 300.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category)
      test_company1 = Company.new({:name => "Burger King"})
      test_company1.save()
      test_expense.add_company(test_company1)
      expect(test_category.company_percentage(test_company)).to(eq(0.25))
    end
  end

end
