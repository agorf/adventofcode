#!/usr/bin/env ruby

dont = false

puts(
  $stdin.read.scan(/(do\(\)|don't\(\)|mul\((\d+),(\d+)\))/).reduce(0) do |sum, (instruction, a, b)|
    case instruction
    when 'do()'
      dont = false
    when "don't()"
      dont = true
    when /\Amul\(/
      sum += (a.to_i * b.to_i) unless dont
    else
      raise 'Unexpected instruction' # Should never happen
    end

    sum
  end
)
