EGGNOG_LITERS = 150

containers = $stdin.map(&:to_i)

min_size = Float::INFINITY

1.upto(containers.size) do |i|
  containers.combination(i) do |combo|
    if combo.reduce(:+) == EGGNOG_LITERS
      min_size = [min_size, combo.size].min
    end
  end
end

count = 0

containers.combination(min_size) do |combo|
  if combo.reduce(:+) == EGGNOG_LITERS
    count += 1
  end
end

puts count
