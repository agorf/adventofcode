#!/usr/bin/env ruby

# Access (safe)
def a(map, (y, x))
  return unless (0...map.size).cover?(y)
  return unless (0...map[0].size).cover?(x)

  map[y][x]
end

def top((y, x))
  [y - 1, x]
end

def right((y, x))
  [y, x + 1]
end

def bottom((y, x))
  [y + 1, x]
end

def left((y, x))
  [y, x - 1]
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

        visit << top(plot)
        visit << right(plot)
        visit << bottom(plot)
        visit << left(plot)

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
    sum += 1 if a(map, top(plot)) != a(map, plot)
    sum += 1 if a(map, right(plot)) != a(map, plot)
    sum += 1 if a(map, bottom(plot)) != a(map, plot)
    sum += 1 if a(map, left(plot)) != a(map, plot)
    sum
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
