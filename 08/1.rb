sum = 0

$stdin.each_line do |line|
  line.chomp!
  sum += line.size - eval(line).size
end

puts sum
