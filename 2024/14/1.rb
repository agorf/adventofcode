#!/usr/bin/env ruby

DY = 103 # Rows
DX = 101 # Columns
MY = (DY - 1) / 2
MX = (DX - 1) / 2

class Robot
  attr_reader :y, :x

  def initialize((y, x), (vy, vx))
    @y = y
    @x = x
    @vy = vy
    @vx = vx
  end

  def move!
    @y = (@y + @vy) % DY # Wrap
    @x = (@x + @vx) % DX # Wrap
  end

  def inspect
    "<#{@y}, #{@x}>"
  end
end

robots =
  $stdin.each_line.with_object([]) do |line, result|
    x, y, vx, vy = line.chomp.scan(/-?\d+/).map(&:to_i)
    result << Robot.new([y, x], [vy, vx])
  end

100.times do
  robots.each(&:move!)
end

quadrants = [0, 0, 0, 0]

robots.each do |robot|
  next if robot.y == MY || robot.x == MX

  i =
    if (0...MY).cover?(robot.y) # Upper half
      0
    else # Lower half
      2
    end

  i +=
    if (0...MX).cover?(robot.x) # Left half
      0
    else # Right half
      1
    end

  quadrants[i] += 1
end

puts quadrants.reduce(:*)
