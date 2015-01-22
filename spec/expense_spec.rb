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

  describe("#category_is") do
    it("will return the category name that an expense is in") do
      test_category = Category.new({:name => "dining out"})
      test_category.save()
      test_expense = Expense.new({:description => "drinks", :date => "2015-01-10", :amount => 14.99, :category_id => test_category.id()})
      test_expense.save()
      expect(test_expense.category_is()).to(eq("dining out"))
    end
  end

  describe("#save") do
    it("saves the expense into the expense database") do
      test_expense = Expense.new({:description => "Cups", :date => "2015-01-19", :amount => 3.49, :category_id => 2})
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


end
