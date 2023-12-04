#!/usr/bin/env ruby

total =
  $stdin.each_line.reduce(0) do |sum, line|
    digits = line.scan(/\d/)
    number = [digits[0], digits[-1]].join.to_i
    sum + number
  end

puts total
