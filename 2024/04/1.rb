#!/usr/bin/env ruby

XMAS = 'XMAS'.freeze

def safe_access(lines, row, col)
  rows_size = lines.size
  cols_size = lines.first.size

  return unless (0...rows_size).cover?(row)
  return unless (0...cols_size).cover?(col)

  lines[row][col]
end

def word(lines, row, col, r_mult, c_mult)
  0.upto(XMAS.size - 1).each_with_object([]) do |i, result|
    result << safe_access(lines, row + i * r_mult, col + i * c_mult)
  end.join
end

def count_xmas(word)
  if word == XMAS
    1
  else
    0
  end
end

def count_xmas_from_position(lines, row, col)
  return 0 if lines[row][col] != XMAS[0]

  count = 0

  -1.upto(1).each do |r_mult|
    -1.upto(1).each do |c_mult|
      count += count_xmas(word(lines, row, col, r_mult, c_mult))
    end
  end

  count
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
