#!/usr/bin/env ruby

SCHEMATIC =
  $stdin.each_line.each_with_object([]) do |line, result|
    result << line.chomp.chars
  end

MAX_ROW = SCHEMATIC[0].size - 1
MAX_COL = SCHEMATIC.size - 1

def boundary_indexes(row, col)
  [
    [row - 1, col - 1],
    [row - 1, col],
    [row - 1, col + 1],
    [row, col - 1],
    [row, col],
    [row, col + 1],
    [row + 1, col - 1],
    [row + 1, col],
    [row + 1, col + 1]
  ].reject { |row, col| row * col < 0 || row > MAX_ROW || col > MAX_COL }
end

def part_number?(indexes)
  indexes.each_with_object([]) do |(row, col), result|
    result.concat(boundary_indexes(row, col))
  end.then do |all_bound_indexes|
    (all_bound_indexes - indexes).any? do |row, col|
      SCHEMATIC[row][col] != '.'
    end
  end
end

total = 0
number = []
indexes = []

SCHEMATIC.each_with_index do |line, row|
  line.each_with_index do |char, col|
    if char =~ /\d/
      number << char
      indexes << [row, col]
    elsif number.any?
      total += number.join.to_i if part_number?(indexes)
      number = []
      indexes = []
    end
  end
end

puts total
