#!/usr/bin/env ruby

SCHEMATIC =
  $stdin.each_line.each_with_object([]) do |line, result|
    result << line.chomp.chars
  end

MAX_ROW = SCHEMATIC[0].size - 1
MAX_COL = SCHEMATIC.size - 1

def number_from_index(index)
  row, col = index
  number = []

  loop do
    char = SCHEMATIC[row][col]

    break if char !~ /\d/

    number << char
    col += 1
  end

  number.join.to_i
end

def first_digit_index(index)
  row, col = index

  loop do
    break if col - 1 < 0 || SCHEMATIC[row][col - 1] !~ /\d/

    col -= 1
  end

  [row, col]
end

def numbers_from_indexes(indexes)
  indexes.map do |index|
    first_digit_index(index)
  end.uniq.map do |index|
    number_from_index(index)
  end
end

def gear_numbers(row, col)
  adjacent_digit_indexes = [
    [row - 1, col - 1],
    [row - 1, col],
    [row - 1, col + 1],
    [row, col - 1],
    [row, col + 1],
    [row + 1, col - 1],
    [row + 1, col],
    [row + 1, col + 1]
  ].reject do |row, col|
    row * col < 0 ||
      row > MAX_ROW ||
      col > MAX_COL ||
      SCHEMATIC[row][col] !~ /\d/
  end

  return [] if adjacent_digit_indexes.empty?

  numbers_from_indexes(adjacent_digit_indexes)
end

def gear_ratio(row, col)
  numbers = gear_numbers(row, col)

  if numbers.size == 2
    numbers.reduce(:*)
  else
    0
  end
end

total = 0

SCHEMATIC.each_with_index do |line, row|
  line.each_with_index do |char, col|
    total += gear_ratio(row, col) if char == '*'
  end
end

puts total
