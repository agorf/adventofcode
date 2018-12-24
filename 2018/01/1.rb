#!/usr/bin/env ruby

puts $stdin.readlines.reduce(0) { |freq, num| freq + num.to_i }
