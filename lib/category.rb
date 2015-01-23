class Category
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO categories (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_categories = []
    categories = DB.exec("SELECT * FROM categories;")
    categories.each() do |category|
      name = category.fetch("name")
      id = category.fetch("id").to_i()
      returned_categories.push(Category.new({:name => name, :id => id}))
    end
    returned_categories
  end

  define_method(:==) do |other_cat|
    self.name() == other_cat.name()
  end


  define_method(:company_percentage) do |company|
    total_expenses_of_category = 0
    category_expenses = DB.exec("SELECT expenses.* FROM
    categories JOIN expenses_categories ON (categories.id = expenses_categories.category_id)
    JOIN expenses ON (expenses_categories.expense_id = expenses.id)
    WHERE categories.id = #{self.id()};")
    category_expenses.each() do |expense|
      amount = expense.fetch("amount").to_f()
      total_expenses_of_category += amount
    end

    total_expenses_of_company = 0
    company_expenses =  DB.exec("SELECT expenses.* FROM
    categories JOIN expenses_categories ON (categories.id = expenses_categories.category_id)
    JOIN expenses ON (expenses_categories.expense_id = expenses.id)
    JOIN companies_expenses ON (companies_expenses.expense_id = expenses.id)
    JOIN companies ON (companies.id = companies_expenses.company_id)
    WHERE companies.id = #{company.id()};")
    company_expenses.each() do |expense|
      amount = expense.fetch("amount").to_f()
      total_expenses_of_company += amount

    end

    result = (total_expenses_of_company./(total_expenses_of_category))
  end

end
