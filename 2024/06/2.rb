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

  def initialize(lines, rows_size, cols_size)
    @lines = lines
    @guard_position = find_guard_position
    @rows_size = rows_size
    @cols_size = cols_size
    @history = {}
    @endless_loop = false
  end

  private def to_s
    lines.map(&:to_s).join("\n")
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

  private def position?(row, col)
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

    unless position?(new_row, new_col)
      lines[row][col] = VISITED
      @guard_position = []
      return
    end

    if lines[new_row][new_col] == OBSTACLE
      lines[row][col] = rotated_guard
      return
    end

    guard = lines[row][col]

    # Visited the same position with the same guard direction
    if @history[[row, col]] == guard
      @endless_loop = true
    end

    @history[[row, col]] = guard
    lines[new_row][new_col] = guard # Move
    lines[row][col] = VISITED

    @guard_position = [new_row, new_col]
  end

  def guard?
    @guard_position.size == 2
  end

  def endless_loop?
    @endless_loop
  end
end

class Array
  def deep_clone
    Marshal.load(Marshal.dump(self))
  end
end

lines = $stdin.each_line.map(&:chomp)
rows_size = lines.size
cols_size = lines.first.size
positions = 0

(0...rows_size).each do |row|
  (0...cols_size).each do |col|
    next if lines[row][col] == Map::OBSTACLE

    lines_copy = lines.deep_clone
    lines_copy[row][col] = Map::OBSTACLE

    map = Map.new(lines_copy, rows_size, cols_size)
    map.advance! while map.guard? && !map.endless_loop?

    positions += 1 if map.endless_loop?
  end
end

puts positions
