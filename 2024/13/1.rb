#!/usr/bin/env ruby

input =
  $stdin.read.split("\n\n").each_with_object([]) do |machine_lines, machines|
    machines <<
      machine_lines.split("\n", 3).each_with_object({}) do |line, machine|
        label, _, x, _, y = line.split(/(?:[:,] |[+=])/)
        machine[label] = [x.to_i, y.to_i]
      end
  end

total_cost = 0

input.each do |machine|
  a_dx, a_dy = machine.fetch('Button A')
  b_dx, b_dy = machine.fetch('Button B')
  px, py = machine.fetch('Prize')
  min_cost = nil

  (0..100).each do |a_times|
    (0..100).each do |b_times|
      x = (a_times * a_dx) + (b_times * b_dx)
      y = (a_times * a_dy) + (b_times * b_dy)

      if x == px && y == py
        min_cost = [min_cost, (3 * a_times) + (1 * b_times)].compact.min
      end
    end
  end

  total_cost += min_cost || 0
end

puts total_cost
