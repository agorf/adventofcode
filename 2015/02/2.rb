sum = $stdin.reduce(0) do |sum, line|
  l, w, h = line.chomp.split('x').map(&:to_i)
  sum + [2*(l+w), 2*(w+h), 2*(h+l)].min + l*w*h
end

puts sum
