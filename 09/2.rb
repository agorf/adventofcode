distances = {}

$stdin.each_line do |line|
  m = line.chop.match(/(\w+) to (\w+) = (\d+)/)
  distances[m[1]] ||= {}
  distances[m[2]] ||= {}
  distances[m[1]][m[2]] = distances[m[2]][m[1]] = m[3].to_i
end

places = distances.keys

puts places.permutation(places.size).map {|places|
  places.each_cons(2).map {|from, to| distances[from][to] }.reduce(:+)
}.max
