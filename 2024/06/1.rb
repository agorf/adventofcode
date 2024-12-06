#!/usr/bin/env ruby

class Map
  UP = '^'.freeze
  RIGHT = '>'.freeze
  DOWN = 'v'.freeze
  LEFT = '<'.freeze
  GUARD = [UP, RIGHT, DOWN, LEFT].freeze
  OBSTACLE = '#'.freeze
  VISITED = 'X'.freeze

  attr_reader :lines

  def initialize(lines)
    @lines = lines
    @guard_position = find_guard_position
    @rows_size = lines.size
    @cols_size = lines.first.size
  end

  private def print
    lines.each do |line|
      puts line
    end
  end

  private def find_guard_position
    lines.each_with_index do |line, row|
      line.chars.each_with_index do |char, col|
        return [row, col] if GUARD.include?(char)
      end
    end

    []
  end

  private def moved_guard_position
    row, col = @guard_position

    case lines[row][col]
    when UP
      [row - 1, col]
    when RIGHT
      [row, col + 1]
    when DOWN
      [row + 1, col]
    when LEFT
      [row, col - 1]
    else
      raise 'Invalid guard character' # Should never happen
    end
  end

  private def has_position?(row, col)
    (0...@rows_size).cover?(row) && (0...@cols_size).cover?(col)
  end

  private def rotated_guard # Clockwise
    row, col = @guard_position

    case lines[row][col]
    when UP
      RIGHT
    when RIGHT
      DOWN
    when DOWN
      LEFT
    when LEFT
      UP
    end
  end

  def advance!
    row, col = @guard_position
    new_row, new_col = moved_guard_position

    unless has_position?(new_row, new_col)
      lines[row][col] = VISITED
      @guard_position = []
      return
    end

    if lines[new_row][new_col] == OBSTACLE
      lines[row][col] = rotated_guard
      return
    end

    lines[new_row][new_col] = lines[row][col] # Move guard
    lines[row][col] = VISITED
    @guard_position = [new_row, new_col]
  end

  def has_guard?
    @guard_position.size == 2
  end

  def visited_positions_count
    lines.reduce(0) do |count, line|
      line.chars.each do |char|
        count += 1 if char == VISITED
      end

      count
    end
  end
end

map = Map.new($stdin.each_line.map(&:chomp))

map.advance! while map.has_guard?

puts map.visited_positions_count
