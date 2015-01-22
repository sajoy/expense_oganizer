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

end
