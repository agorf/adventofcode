sum = $stdin.reduce(0) do |sum, line|
  line.chomp!
  sum + (line.inspect.size - line.size)
end

puts sum
