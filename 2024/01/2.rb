#!/usr/bin/env ruby

left = []
right = []

$stdin.each_line do |line|
  l, r = line.chomp.split.map(&:to_i)
  left << l
  right << r
end

right_freq =
  right.each_with_object(Hash.new(0)) do |r, result|
    result[r] += 1
  end

result = 0

left.each do |l|
  result += l * right_freq[l]
end

puts result
