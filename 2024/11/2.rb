#!/usr/bin/env ruby

MAX_LEVEL = 75

def blink_number(number)
  return [1] if number == 0

  number_s = number.to_s
  size = number_s.size

  return [number * 2024] if size.odd?

  [
    number_s[0...size / 2].to_i,
    number_s[size / 2..].to_i
  ]
end

def dfs(number, level = 0, cache = {})
  cache_key = [number, level]
  cached = cache[cache_key]
  return cached if cached

  return (cache[cache_key] = 1) if level == MAX_LEVEL

  cache[cache_key] =
    blink_number(number).sum do |num|
      dfs(num, level + 1, cache)
    end
end

stones = $stdin.read.chomp.split.map(&:to_i)

puts(stones.sum { |stone| dfs(stone) })
