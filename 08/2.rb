sum = 0

$stdin.each_line do |line|
  line.chomp!
  sum += line.inspect.size - line.size
end

puts sum
