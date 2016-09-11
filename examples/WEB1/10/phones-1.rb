file = File.open('file.txt')

file.each_line do |line|
  puts line
end
