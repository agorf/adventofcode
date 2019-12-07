#!/usr/bin/env ruby

panel = Hash.new { |hash, key| hash[key] = [] }

paths = $stdin.readlines.map { |line| line.chomp.split(',') }

paths.each_with_index do |path, i|
  row = 0
  col = 0

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

      panel[[row, col]] << i
    end
  end
end

min_distance = Float::INFINITY

panel.each do |((i, j), paths)|
  next if paths.uniq.size <= 1

  min_distance = [min_distance, i.abs + j.abs].min
end

puts min_distance
