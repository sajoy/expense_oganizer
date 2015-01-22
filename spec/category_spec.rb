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

end
