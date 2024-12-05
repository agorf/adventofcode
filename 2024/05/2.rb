#!/usr/bin/env ruby

rules_input, updates_input = $stdin.read.chomp.split("\n\n", 2)

rules =
  rules_input.split("\n").each_with_object(Hash.new { |h, k| h[k] = [] }) do |pair_str, result|
    before, after = pair_str.split('|', 2).map(&:to_i)
    result[before] << after
  end

updates =
  updates_input.split("\n").map { |upd_str| upd_str.split(',').map(&:to_i) }

incorrect_updates =
  updates.select do |update|
    update.each_cons(2).any? do |pair|
      before, after = pair
      !rules[before].include?(after)
    end
  end

fixed_updates =
  incorrect_updates.map do |update|
    update.sort do |a, b|
      rules[a].include?(b) ? -1 : 1
    end
  end

puts(
  fixed_updates.reduce(0) do |sum, update|
    sum + update[update.size / 2]
  end
)
