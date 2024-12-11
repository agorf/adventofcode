#!/usr/bin/env ruby

FREE = '.'.freeze

def checksum(c_d_map)
  c_d_map.each_with_index.reduce(0) do |result, (c, i)|
    next result if c == FREE

    result + (i * c)
  end
end

def compact!(d_map)
  (d_map.size - 1).downto(0) do |r|
    next if d_map[r][0] == FREE

    0.upto(r - 1) do |l|
      next unless d_map[l].include?(FREE) # Not free space
      next if d_map[l].count { |c| c == FREE } < d_map[r].size # Not enough free space

      i = d_map[l].index(FREE)

      # Move
      0.upto(d_map[r].size - 1) do |j|
        d_map[l][i + j] = d_map[r][j]
        d_map[r][j] = FREE
      end
    end
  end

  d_map.flatten
end

def disk_map(input)
  id = 0

  input.each_with_index.with_object([]) do |(times, i), result|
    next if times == 0

    if i.odd? # Free space
      x = FREE
    else
      x = id
      id += 1
    end

    result << ([x] * times)
  end
end

def parse_input(input)
  input.each_char.filter_map do |c|
    c.to_i if c != "\n"
  end
end

puts checksum(compact!(disk_map(parse_input($stdin))))
