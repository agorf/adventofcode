EGGNOG_LITERS = 150

containers = $stdin.map(&:to_i)

min_size = 1.upto(containers.size).find do |i|
  containers.combination(i).find do |combo|
    combo.reduce(:+) == EGGNOG_LITERS
  end
end

count = 0

containers.combination(min_size) do |combo|
  if combo.reduce(:+) == EGGNOG_LITERS
    count += 1
  end
end

puts count
