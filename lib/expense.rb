class Expense

  attr_reader(:description, :amount, :date, :id)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (date, amount, description) VALUES ('#{@date}', #{@amount}, '#{@description}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_expenses = []
    expenses = DB.exec("SELECT * FROM expenses;")
    expenses.each() do |expense|
      description = expense.fetch("description")
      amount = expense.fetch("amount").to_f()
      date = expense.fetch("date")
      id = expense.fetch("id").to_i()
      returned_expenses.push(Expense.new({:description => description, :amount => amount, :date => date, :id => id}))
    end
    returned_expenses
  end

  define_method(:==) do |other_expense|
    self.description() == other_expense.description() &&
    self.amount() == other_expense.amount() &&
    self.date() == other_expense.date()
  end

  define_method(:add_category) do |category|
    DB.exec("INSERT INTO expenses_categories (expense_id, category_id) VALUES (#{self.id()}, #{category.id()});")
  end

  define_method(:category_is) do
    category = DB.exec("SELECT categories.* FROM
    expenses JOIN expenses_categories ON (expenses.id = expenses_categories.expense_id)
    JOIN categories ON (expenses_categories.category_id = categories.id)
    WHERE expenses.id = #{self.id()};")

    array = []
    category.each() do |cat|
      name = cat.fetch("name")
      id = cat.fetch("id")
      new_category =Category.new({:name => name, :id => id})

      array.push(new_category.name())
    end
    array
  end

  define_singleton_method(:percentage) do |category|
    total_expenses = 0
    expenses = DB.exec("SELECT * FROM expenses")
      expenses.each() do |expense|
        amount = expense.fetch("amount").to_f()
        total_expenses += amount
      end

    total_expenses_of_category = 0
    category_expenses = DB.exec("SELECT expenses.* FROM
    categories JOIN expenses_categories ON (categories.id = expenses_categories.category_id)
    JOIN expenses ON (expenses_categories.expense_id = expenses.id)
    WHERE categories.id = #{category.id()};")
    category_expenses.each() do |expense|
      amount = expense.fetch("amount").to_f()
      total_expenses_of_category += amount
    end
    result = (total_expenses_of_category./(total_expenses))
  end



  define_method(:add_company) do |company|
    DB.exec("INSERT INTO companies_expenses (expense_id, company_id) VALUES (#{self.id()}, #{company.id()});")
  end

  define_method(:company_is) do
    company = DB.exec("SELECT companies.* FROM
    expenses JOIN companies_expenses ON (expenses.id = companies_expenses.expense_id)
    JOIN companies ON (companies_expenses.company_id = companies.id)
    WHERE expenses.id = #{self.id()};")

    array = []
    company.each() do |company|
      name = company.fetch("name")
      id = company.fetch("id")
      new_company = Company.new({:name => name, :id => id})

      array.push(new_company.name())
    end
    array
  end



end
