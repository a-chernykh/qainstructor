file = File.open('file.txt')

file.each_line do |line|
  if line =~ /\(\d{3}\) \d{3} \d{4}/
    puts line
  end
end
