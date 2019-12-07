#!/usr/bin/env ruby

def calculate_module_fuel(mass)
  total_fuel = 0

  loop do
    fuel = (mass / 3).floor - 2

    break if fuel < 0

    total_fuel += fuel
    mass = fuel
  end

  total_fuel
end

modules = $stdin.readlines.map(&:to_i)

puts(
  modules.reduce(0) do |total, mass|
    total + calculate_module_fuel(mass)
  end
)
