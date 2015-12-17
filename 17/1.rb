containers = $stdin.map(&:to_i)

count = 0

1.upto(containers.size) do |i|
  containers.combination(i) do |combo|
    if combo.reduce(:+) == 150
      count += 1
    end
  end
end

puts count
