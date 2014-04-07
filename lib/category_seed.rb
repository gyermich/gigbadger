require 'csv'

class CategorySeed

  def self.all
    CSV.read("./lib/categories.csv").map do |array|
      create_category(array)
    end
  end

  def self.create_category(category_array)
    Category.create(
      name: category_array[0]
      )
  end
end