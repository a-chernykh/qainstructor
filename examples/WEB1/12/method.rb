def print_color(product)
  if product == "Apples"
    puts "red"
  else
    puts "unknown"
  end
end

print_color("Apples")  # Prints "red"
print_color("Bananas") # Prints "unknown"
print_color("Oranges") # Prints "unknown"
