#!/usr/bin/env ruby

def antinode_positions((a, b), (rows_size, cols_size))
  valid_position = ->((row, col)) do
    (0...rows_size).cover?(row) && (0...cols_size).cover?(col)
  end

  yield a # Antenna
  yield b # Antenna

  # Go one way
  row_diff = a[0] - b[0]
  col_diff = a[1] - b[1]
  a2 = a.dup

  loop do
    a2[0] += row_diff
    a2[1] += col_diff

    break unless valid_position.call(a2)

    yield a2
  end

  # Go the other way
  row_diff = b[0] - a[0]
  col_diff = b[1] - a[1]
  b2 = b.dup

  loop do
    b2[0] += row_diff
    b2[1] += col_diff

    break unless valid_position.call(b2)

    yield b2
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
    antinode_positions(pair_positions, [rows_size, cols_size]) do |row, col|
      antinodes[row][col] = true
    end
  end
end

puts(
  antinodes.reduce(0) do |sum, row|
    sum + row.count(&:itself)
  end
)
