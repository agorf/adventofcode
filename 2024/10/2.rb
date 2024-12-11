#!/usr/bin/env ruby

class Map
  def initialize(lines)
    @lines = lines.map { |line| line.chars.map(&:to_i) }
    @row_size = @lines.size
    @col_size = @lines[0].size
  end

  private def safe_position(position)
    (0...@row_size).cover?(position[0]) &&
      (0...@col_size).cover?(position[1])
  end

  private def possible_transition(from, to)
    value(to) - value(from) == 1
  end

  private def next_positions(from_pos)
    [
      [from_pos[0] - 1, from_pos[1]], # Top
      [from_pos[0], from_pos[1] + 1], # Right
      [from_pos[0] + 1, from_pos[1]], # Bottom
      [from_pos[0], from_pos[1] - 1]  # Left
    ].select do |to_pos|
      safe_position(to_pos) && possible_transition(from_pos, to_pos)
    end
  end

  private def value(position)
    @lines[position[0]][position[1]]
  end

  private def trailhead_rating(position)
    score = 0
    visit = next_positions(position)

    while (pos = visit.pop)
      if value(pos) == 9
        score += 1
      else
        visit.concat(next_positions(pos))
      end
    end

    score
  end

  private def trailhead_positions
    Enumerator.new do |y|
      @lines.each_with_index do |line, i|
        line.each_with_index do |c, j|
          y << [i, j] if c == 0
        end
      end
    end
  end

  def trailheads_rating
    trailhead_positions.reduce(0) do |sum, position|
      sum + trailhead_rating(position)
    end
  end
end

puts Map.new($stdin.each_line.map(&:chomp)).trailheads_rating
