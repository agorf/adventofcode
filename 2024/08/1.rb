#!/usr/bin/env ruby

def antinode_position(a, b)
  [(2 * a[0]) - b[0], (2 * a[1]) - b[1]]
end

def antinode_positions((a, b), (rows_size, cols_size))
  [antinode_position(a, b), antinode_position(b, a)].select do |row, col|
    (0...rows_size).cover?(row) && (0...cols_size).cover?(col)
  end
end

antennas = $stdin.each_line.map(&:chomp)
rows_size = antennas.size
cols_size = antennas[0].size
positions_by_antenna = Hash.new { |h, k| h[k] = [] }

(0...rows_size).each do |row|
  (0...cols_size).each do |col|
    antenna = antennas[row][col]
    positions_by_antenna[antenna] << [row, col] if antenna != '.'
  end
end

antinodes = Array.new(rows_size) { Array.new(cols_size) { false } }

positions_by_antenna.each_value do |positions|
  positions.combination(2) do |pair_positions|
    antinode_positions(pair_positions, [rows_size, cols_size]).each do |row, col|
      antinodes[row][col] = true
    end
  end
end

puts(
  antinodes.reduce(0) do |sum, row|
    sum + row.count(&:itself)
  end
)
