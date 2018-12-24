#!/usr/bin/env ruby

FABRIC_SIZE = 1000

fabric = Array.new(FABRIC_SIZE) { Array.new(FABRIC_SIZE, 0) }

$stdin.each_line do |line|
  _, x, y, w, h = line.match(/(\d+),(\d+): (\d+)x(\d+)/).to_a.map(&:to_i)

  (x...x + w).each do |i|
    (y...y + h).each do |j|
      fabric[i][j] += 1
    end
  end
end

count = 0

(0...FABRIC_SIZE).each do |i|
  (0...FABRIC_SIZE).each do |j|
    if fabric[i][j] >= 2
      count += 1
    end
  end
end

puts count
