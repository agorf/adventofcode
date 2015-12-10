sum = 0

$stdin.each_line do |line|
  l, w, h = line.chop.split('x').map(&:to_i)
  products = [l*w, w*h, h*l]
  sum += products.map {|n| 2*n }.reduce(:+)
  sum += products.min
end

puts sum
