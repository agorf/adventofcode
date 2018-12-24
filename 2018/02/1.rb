#!/usr/bin/env ruby

two = three = 0

$stdin.each_line do |line|
  freqs = line.chomp.chars.group_by(&:itself).values.map(&:size).uniq

  if freqs.include?(2)
    two += 1
  end

  if freqs.include?(3)
    three += 1
  end
end

puts two * three
