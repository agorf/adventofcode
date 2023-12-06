#!/usr/bin/env ruby

total = 0

def card_points(winning, have)
  value = 1
  points = 0
  common = winning & have

  common.size.times do |i|
    points += value
    value *= 2 if i > 0
  end

  points
end

$stdin.each_line do |line|
  winning, have =
    line.split(':', 2)[1].split('|', 2).map { |col| col.scan(/\d+/).map(&:to_i) }
  total += card_points(winning, have)
end

puts total