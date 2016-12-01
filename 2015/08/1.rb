sum = $stdin.reduce(0) do |sum, line|
  line.chomp!
  sum + (line.size - eval(line).size)
end

puts sum
