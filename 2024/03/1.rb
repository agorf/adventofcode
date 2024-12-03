#!/usr/bin/env ruby

puts(
  $stdin.read.scan(/mul\((\d+),(\d+)\)/).reduce(0) do |sum, (a, b)|
    sum + (a.to_i * b.to_i)
  end
)
