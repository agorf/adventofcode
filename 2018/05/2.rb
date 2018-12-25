#!/usr/bin/env ruby

REACTIVE_PAIRS = Regexp.union(
  *('a'..'z').
    zip('A'..'Z').
    concat(('A'..'Z').zip('a'..'z')).
    map(&:join).
    freeze
)

def react_polymer(polymer)
  polymer = polymer.dup

  loop do
    prev_polymer = polymer.dup
    polymer.gsub!(REACTIVE_PAIRS, '')

    return polymer if polymer == prev_polymer
  end
end

def clean_polymer(polymer, units)
  polymer.tr(units, '')
end

polymer = $stdin.gets.chomp

length = ('a'..'z').map { |c|
  react_polymer(clean_polymer(polymer, c + c.upcase)).size
}.min

puts length
