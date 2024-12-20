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
  px, py = machine.fetch('Prize').map { |n| n + 10_000_000_000_000 }

  a_times, a_mod = ((b_dy * px) - (b_dx * py)).divmod((a_dx * b_dy) - (b_dx * a_dy))

  next if a_mod > 0

  b_times, b_mod = ((a_dy * px) - (a_dx * py)).divmod((b_dx * a_dy) - (a_dx * b_dy))

  next if b_mod > 0

  next if (a_times * a_dx) + (b_times * b_dx) != px

  next if (a_times * a_dy) + (b_times * b_dy) != py

  total_cost += (3 * a_times) + (1 * b_times)
end

puts total_cost
