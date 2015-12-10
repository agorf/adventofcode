sum = 0

$stdin.each_line do |line|
  l, w, h = line.chop.split('x').map(&:to_i)
  sum += [2*(l+w), 2*(w+h), 2*(h+l)].min
  sum += l*w*h
end

puts sum
