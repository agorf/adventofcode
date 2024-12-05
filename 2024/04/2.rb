#!/usr/bin/env ruby

def safe_access(lines, row, col)
  rows_size = lines.size
  cols_size = lines.first.size

  return unless (0...rows_size).cover?(row)
  return unless (0...cols_size).cover?(col)

  lines[row][col]
end

def count_xmas_from_position(lines, row, col)
  return 0 if lines[row][col] != 'A'

  mas_top_left_bottom_right =
    safe_access(lines, row - 1, col - 1) == 'M' &&
    safe_access(lines, row + 1, col + 1) == 'S'

  sam_top_left_bottom_right =
    safe_access(lines, row - 1, col - 1) == 'S' &&
    safe_access(lines, row + 1, col + 1) == 'M'

  mas_bottom_left_top_right =
    safe_access(lines, row + 1, col - 1) == 'M' &&
    safe_access(lines, row - 1, col + 1) == 'S'

  sam_bottom_left_top_right =
    safe_access(lines, row + 1, col - 1) == 'S' &&
    safe_access(lines, row - 1, col + 1) == 'M'

  if (mas_top_left_bottom_right || sam_top_left_bottom_right) &&
     (mas_bottom_left_top_right || sam_bottom_left_top_right)
    1
  else
    0
  end
end

lines = $stdin.each_line.map(&:chomp)
rows_size = lines.size
cols_size = lines.first.size
count = 0

(0...rows_size).each do |row|
  (0...cols_size).each do |col|
    count += count_xmas_from_position(lines, row, col)
  end
end

puts count
