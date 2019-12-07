#!/usr/bin/env ruby

panel = Hash.new { |hash, key| hash[key] = {} }

paths = $stdin.readlines.map { |line| line.chomp.split(',') }

paths.each_with_index do |path, i|
  row = 0
  col = 0
  total_steps = 0

  path.each do |instruction|
    _, direction, steps = instruction.match(/([UDLR])(\d{1,3})/).to_a
    steps = steps.to_i

    steps.times do
      case direction
      when 'U'
        row -= 1
      when 'D'
        row += 1
      when 'L'
        col -= 1
      when 'R'
        col += 1
      end

      total_steps += 1
      panel[[row, col]][i] = total_steps
    end
  end
end

min_steps = Float::INFINITY

panel.each_value do |paths|
  next if paths.size <= 1

  min_steps = [min_steps, paths.values.sum].min
end

puts min_steps
