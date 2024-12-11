#!/usr/bin/env ruby

def blink(stones)
  result = []

  stones.each do |number|
    if number == 0
      result << 1
    elsif number.to_s.size.even?
      result.concat(
        number.to_s.chars.each_slice(
          number.to_s.size / 2
        ).to_a.map { |nums| nums.join.to_i }
      )
    else
      result << (number * 2024)
    end
  end

  result
end

stones = $stdin.read.chomp.split.map(&:to_i)

25.times do
  stones = blink(stones)
end

puts stones.size
