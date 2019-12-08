#!/usr/bin/env ruby

range = Range.new(*$stdin.read.split('-', 2).map(&:to_i))

count = 0

range.each do |num|
  next if num.to_s.size != 6

  next if num.to_s !~ /(\d)\1/

  next if num.to_s.chars.sort.join != num.to_s

  next if num.to_s.scan(/((\d)\2+)/).none? { |group, _| group.size == 2 }

  count += 1
end

puts count
