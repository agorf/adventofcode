#!/usr/bin/env ruby

program = $stdin.read.chomp.split(',').map(&:to_i)

program[1] = 12
program[2] = 2

(0..).step(4) do |i|
  case program[i]
  when 1
    program[program[i + 3]] = program[program[i + 1]] + program[program[i + 2]]
  when 2
    program[program[i + 3]] = program[program[i + 1]] * program[program[i + 2]]
  when 99
    break
  end
end

puts program[0]
