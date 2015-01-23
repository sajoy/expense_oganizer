class Company
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO companies (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:all) do
    returned_companies = []
    companies = DB.exec("SELECT * FROM companies;")
    companies.each() do |company|
      name = company.fetch("name")
      id = company.fetch("id").to_i()
      returned_companies.push(Company.new({:name => name, :id => id}))
    end
    returned_companies
  end

  define_method(:==) do |other_com|
    self.name() == other_com.name()
  end

end
