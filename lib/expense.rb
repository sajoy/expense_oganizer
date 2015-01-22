class Expense

  attr_reader(:description, :amount, :date, :id, :category_id)

  define_method(:initialize) do |attributes|
    @description = attributes[:description]
    @amount = attributes[:amount]
    @date = attributes[:date]
    @id = attributes[:id]
    @category_id = attributes[:category_id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO expenses (date, amount, description, category_id) VALUES ('#{@date}', #{@amount}, '#{@description}', #{@category_id}) RETURNING id;")
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

  define_method(:category_is) do
    category = DB.exec("SELECT * FROM expenses JOIN categories ON
    (expenses.category_id = categories.id) WHERE categories.id = #{self.category_id()};")
    array = []
    category.each() do |cat|
      name = cat.fetch("name")
      id = cat.fetch("id")
      array.push(Category.new({:name => name, :id => id}))
    end
    array[0].name()
  end

end


# SELECT * FROM
# animals JOIN trainers ON (animals.trainer_id() = trainers.id())
# WHERE trainers.id() = 1;
