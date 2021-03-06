#!/usr/bin/env ruby

$stdin.readlines.map(&:chomp).combination(2).each do |a, b|
  diff = 0
  diff_i = 0

  (0...a.size).each do |i|
    if a[i] != b[i]
      diff += 1
      diff_i = i
    end

    break if diff > 1
  end

  next if diff > 1

  a.slice!(diff_i)
  puts a

  break
end
