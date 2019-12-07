#!/usr/bin/env ruby

def calculate_module_fuel(mass)
  (mass / 3).floor - 2
end

modules = $stdin.readlines.map(&:to_i)

puts(
  modules.reduce(0) do |total, mass|
    total + calculate_module_fuel(mass)
  end
)
