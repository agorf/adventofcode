class Grid
  ON  = '#'
  OFF = '.'

  def initialize(grid)
    @grid = grid
    @size = grid.size
  end

  def advance!
    new_grid = Array.new(size) { Array.new(size) }

    each_light do |state, i, j|
      new_grid[i][j] = state

      if state == ON
        new_grid[i][j] = OFF unless [2, 3].include?(neighbors(i, j))
      else # state == OFF
        new_grid[i][j] = ON if neighbors(i, j) == 3
      end
    end

    @grid = new_grid
  end

  def lights_on
    count = 0
    each_light {|state| count += 1 if state == ON }
    count
  end

  def to_s
    grid.join("\n")
  end

  private

  def corner?(x, y)
    return true if x == 0        && y == 0
    return true if x == 0        && y == size - 1
    return true if x == size - 1 && y == 0
    return true if x == size - 1 && y == size - 1
    false
  end

  def each_light(x = (0...size), y = (0...size))
    x.each do |i|
      y.each do |j|
        yield(light(i, j), i, j)
      end
    end
  end

  attr_reader :grid

  def in_grid?(n)
    n >= 0 && n < size
  end

  def light(x, y)
    return ON if corner?(x, y)
    return OFF unless in_grid?(x) && in_grid?(y)
    grid[x][y]
  end

  def neighbors(x, y)
    count = 0

    each_light((x - 1..x + 1), (y - 1..y + 1)) do |state, i, j|
      if (i != x || j != y) && state == ON
        count += 1
      end
    end

    count
  end

  attr_reader :size
end

grid_ary = $stdin.reduce([]) {|grid, line| grid << line.chop.chars }
grid = Grid.new(grid_ary)

100.times do
  grid.advance!
end

puts grid.lights_on
