#!/usr/bin/env ruby

CUBES = { 'red' => 12, 'green' => 13, 'blue' => 14 }.freeze

def possible_game?(sets)
  sets.each do |set|
    set.each do |color, cubes|
      next if CUBES.fetch(color) >= cubes

      return false
    end
  end

  true
end

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

  total += game_id if possible_game?(sets)
end

puts total