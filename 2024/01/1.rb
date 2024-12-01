#!/usr/bin/env ruby

left = []
right = []

$stdin.each_line do |line|
  l, r = line.chomp.split.map(&:to_i)
  left << l
  right << r
end

left.sort!
right.sort!

result = 0

left.each_with_index do |l, i|
  r = right[i]
  result += (l - r).abs
end

puts result
