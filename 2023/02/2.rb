#!/usr/bin/env ruby

total = 0

$stdin.each_line do |line|
  game_id, sets =
    line.chomp.split(': ', 2).then do |line_parts|
      [
        line_parts[0][/\d+/].to_i,
        line_parts[1].split('; ').map do |set_parts|
          Hash[
            *set_parts.split(', ').flat_map do |cube_parts|
              cubes, color = cube_parts.split(' ')
              [color, cubes.to_i]
            end
          ]
        end
      ]
    end

  min = { 'red' => 0, 'green' => 0, 'blue' => 0 }

  total +=
    sets.each_with_object(min) do |set, result|
      result.merge!(set) do |color, *cubes|
        cubes.max
      end
    end.values.reduce(:*)
end

puts total