sum = $stdin.each_line.reduce(0) do |sum, line|
  line.chomp!
  sum + (line.size - eval(line).size)
end

puts sum
