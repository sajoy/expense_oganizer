require('rspec')
require('expense')
require('category')
require('company')
# require other class files
require('pg')
require('pry')

DB = PG.connect({:dbname => "expense_organizer_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
    DB.exec("DELETE FROM companies *;")
  end
end
