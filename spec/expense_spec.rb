require('spec_helper')

describe('Expense') do

  describe('#description') do
    it("will return the description of the expense") do
      test_expense = Expense.new({:description => "Tabor cart", :date => "2015-01-22", :amount => 9.00})
      expect(test_expense.description()).to(eq("Tabor cart"))
    end
  end

  describe('#amount') do
    it("returns the amount spent") do
      test_expense = Expense.new({:description => "Jelly beans", :date => "2014-12-31", :amount => 2.95})
      expect(test_expense.amount()).to(eq(2.95))
    end
  end

  describe("#date") do
    it("returns the date of the expense") do
      test_expense = Expense.new({:description => "the best donut ever", :date => "2015-01-10", :amount => 1.15})
      expect(test_expense.date()).to(eq("2015-01-10"))
    end
  end

  describe("#id") do
    it("returns the ID of the expense") do
      test_expense = Expense.new({:description => "Toothpicks", :date => "2015-01-20", :amount => 0.99, :id => 1})
      expect(test_expense.id()).to(eq(1))
    end
  end

  describe("#save") do
    it("saves the expense into the expense database") do
      test_expense = Expense.new({:description => "Cups", :date => "2015-01-19", :amount => 3.49})
      test_expense.save()
      expect(Expense.all()).to(eq([test_expense]))
    end
  end

  describe("#all") do
    it("starts empty") do
      expect(Expense.all()).to(eq([]))
    end
  end

  describe("#==") do
    it("says two expenses are equal if all of the attributes are the same") do
      test_expense1 = Expense.new({:description => "headphones", :date => "2014-11-11", :amount => 145})
      test_expense2 = Expense.new({:description => "headphones", :date => "2014-11-11", :amount => 145})
      expect(test_expense1).to(eq(test_expense2))
    end
  end




# CATEGORY METHOD SPECS

  describe("#add_category") do
    it("will add a category to an expense") do
      test_category = Category.new({:name => "travel"})
      test_category.save()
      test_expense = Expense.new({:description => "Thailand", :amount => 100.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category)
      expect(test_expense.category_is()).to(eq([test_category.name()]))
    end

    it("will allow for an expense to have multiple categories") do
      test_category = Category.new({:name => "travel"})
      test_category.save()
      test_category2 = Category.new({:name => "leisure"})
      test_category2.save()
      test_expense = Expense.new({:description => "Thailand", :amount => 100.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category)
      test_expense.add_category(test_category2)
      expect(test_expense.category_is()).to(eq([test_category.name(),test_category2.name()]))
    end
  end

  describe("#category_is") do
    it("will return the category name that an expense is in") do
      test_category = Category.new({:name => "dining out"})
      test_category.save()
      test_expense = Expense.new({:description => "drinks", :date => "2015-01-10", :amount => 14.99})
      test_expense.save()
      test_expense.add_category(test_category)
      expect(test_expense.category_is()).to(eq([test_category.name()]))
    end
  end

  describe(".percentage") do
    it("will return how many percent of the expenses was used in a desired category") do
      test_category = Category.new({:name => "travel"})
      test_category.save()
      test_expense = Expense.new({:description => "Thailand", :amount => 100.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category)
      test_category1 = Category.new({:name => "drugs"})
      test_category1.save()
      test_expense = Expense.new({:description => "145th Ave Secret", :amount => 300.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_category(test_category1)
      expect(Expense.percentage(test_category)).to(eq(0.25))
    end
  end

# COMPANY METHOD SPECS


  describe("#add_company") do
    it("will add a company to an expense") do
      test_company = Company.new({:name => "McDs"})
      test_company.save()
      test_expense = Expense.new({:description => "fries", :amount => 100.00, :date => "2011-05-15"})
      test_expense.save()
      test_expense.add_company(test_company)
      expect(test_expense.company_is()).to(eq([test_company.name()]))
    end
  end

  describe("#company_is") do
    it("will return the company name of the purchase") do
      test_company = Company.new({:name => "McDs"})
      test_company.save()
      test_expense = Expense.new({:description => "milkshake", :date => "2015-01-10", :amount => 14.99})
      test_expense.save()
      test_expense.add_company(test_company)
      expect(test_expense.company_is()).to(eq([test_company.name()]))
    end
  end




end
