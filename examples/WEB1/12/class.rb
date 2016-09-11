class Fruit
  def initialize(name)
    @name = name
  end

  def print_name
    puts @name
  end
end

apples = Fruit.new("Apples")
apples.print_name # prints "Apples"

bananas = Fruit.new("Bannas")
bananas.print_name # prints "Bananas"

oranges = Fruit.new("Oranges")
oranges.print_name # prints "Oranges"
