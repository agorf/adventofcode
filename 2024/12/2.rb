#!/usr/bin/env ruby

# Access (safe)
def a(map, (y, x))
  return unless (0...map.size).cover?(y)
  return unless (0...map[0].size).cover?(x)

  map[y][x]
end

# Coords
def c(sym, (y, x))
  case sym
  when :top
    [y - 1, x]
  when :top_right
    [y - 1, x + 1]
  when :right
    [y, x + 1]
  when :bottom_right
    [y + 1, x + 1]
  when :bottom
    [y + 1, x]
  when :bottom_left
    [y + 1, x - 1]
  when :left
    [y, x - 1]
  when :top_left
    [y - 1, x - 1]
  end
end

def plot_regions(map)
  visited = {}

  map.each_with_index.with_object([]) do |(row, y), regions|
    row.each_index do |x|
      start_plot = [y, x]

      next if visited[start_plot]

      visit = [start_plot]
      region = []
      start_letter = a(map, start_plot)

      loop do
        plot = visit.pop

        break if plot.nil?

        next if visited[plot]
        next if a(map, plot) != start_letter

        region << plot

        visit << c(:top, plot)
        visit << c(:right, plot)
        visit << c(:bottom, plot)
        visit << c(:left, plot)

        visited[plot] = true
      end

      regions << region if region.any?
    end
  end
end

def plot_region_area(region)
  region.size
end

def plot_region_perimeter(map, region)
  region.reduce(0) do |sum, plot|
    p = a(map, plot)
    t = a(map, c(:top, plot))
    tr = a(map, c(:top_right, plot))
    r = a(map, c(:right, plot))
    br = a(map, c(:bottom_right, plot))
    b = a(map, c(:bottom, plot))
    bl = a(map, c(:bottom_left, plot))
    l = a(map, c(:left, plot))
    tl = a(map, c(:top_left, plot))

    # Corners
    sum + [
      t != p && r != p, # Top-right
      b != p && r != p, # Bottom-right
      b != p && l != p, # Bottom-left
      t != p && l != p, # Top-left
      t == p && r == p && tr != p, # Inner top-right
      b == p && r == p && br != p, # Inner bottom-right
      b == p && l == p && bl != p, # Inner bottom-left
      t == p && l == p && tl != p # Inner top-left
    ].select(&:itself).size
  end
end

def plot_region_price(map, region)
  plot_region_area(region) * plot_region_perimeter(map, region)
end

map = $stdin.readlines.map { |line| line.chomp.chars }

puts(
  plot_regions(map).reduce(0) do |sum, region|
    sum + plot_region_price(map, region)
  end
)
