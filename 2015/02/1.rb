sum = $stdin.reduce(0) do |sum, line|
  l, w, h = line.chomp.split('x').map(&:to_i)
  products = [l*w, w*h, h*l]
  sum + products.map {|n| 2*n }.reduce(:+) + products.min
end

puts sum
